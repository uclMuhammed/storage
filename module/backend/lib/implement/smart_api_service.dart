// ignore_for_file: avoid_shadowing_type_parameters

import 'dart:convert';
import '../abstract/index.dart';
import '../errors/api_exception.dart';
import '../errors/error_codes.dart';
import 'smart_cache_manager.dart';
import '../models/paginated_response.dart';
import '../exception/unauthorized_exception.dart';
import 'package:flutter/foundation.dart';
import '../exception/http_custom_exception.dart';
import 'service_auth_client.dart';
import 'package:http/http.dart' as http;

class SmartApiService<T extends IModel> extends IApiService<T> {
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final SmartCacheManager _cacheManager;
  @override
  final client = http.Client();

  SmartApiService({
    required this.fromJson,
    required this.toJson,
    required super.header,
    required super.endPoint,
    required super.baseUrl,
  }) : _cacheManager = SmartCacheManager();

  Map<String, String> _getHeadersWithToken(String token) {
    return {
      ...?header,
      'Authorization': 'Bearer $token',
    };
  }

  Future<T> _handleApiError<T>({
    required Future<T> Function() operation,
    String? customMessage,
  }) async {
    try {
      // Token kontrolü
      final token = await ServiceAuthClient().getToken();
      if (token == null) {
        throw ApiException(
          errorCode: ApiErrorCode.unauthorized,
          customMessage: 'Oturum süresi doldu',
        );
      }

      // Header'ı güncelle
      header = _getHeadersWithToken(token);

      return await operation();
    } on UnauthorizedException {
      throw ApiException(
        errorCode: ApiErrorCode.unauthorized,
        customMessage: 'Oturum süresi doldu',
      );
    } on HttpCustomException catch (e) {
      if (e.statusCode == 401) {
        throw ApiException(
          errorCode: ApiErrorCode.unauthorized,
          customMessage: 'Oturum süresi doldu',
        );
      }
      throw ApiException(
        errorCode: _mapStatusCodeToErrorCode(e.statusCode),
        customMessage: customMessage ?? e.message,
        metaData: {
          'statusCode': e.statusCode,
          'error': e.toString(),
        },
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        errorCode: ApiErrorCode.unknown,
        customMessage: customMessage ?? 'Beklenmeyen bir hata oluştu',
        metaData: {'error': e.toString()},
      );
    }
  }

  ApiErrorCode _mapStatusCodeToErrorCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return ApiErrorCode.unauthorized;
      case 403:
        return ApiErrorCode.forbidden;
      case 404:
        return ApiErrorCode.notFound;
      case 408:
      case 504:
        return ApiErrorCode.networkError;
      default:
        return ApiErrorCode.unknown;
    }
  }

  // CRUD Operations with Cache
  @override
  Future<List<T>> getAll({
    Map<String, dynamic>? queryParameters,
    CachePriority priority = CachePriority.medium,
  }) async {
    return _handleApiError(
      operation: () async {
        final cacheKey = _generateCacheKey('getAll', queryParameters);
        return await _cacheManager.getOrFetch<List<T>>(
          cacheKey,
          () => _fetchAll(),
          priority: priority,
        );
      },
      customMessage: 'Veriler yüklenirken bir hata oluştu',
    );
  }

  @override
  Future<T> getById(dynamic id) async {
    return _handleApiError(
      operation: () async {
        final cacheKey = _generateCacheKey('getById', {'id': id});
        final result = await _cacheManager.getOrFetch<T?>(
          cacheKey,
          () => _fetchById(id),
          priority: CachePriority.medium,
        );
        if (result == null) {
          throw ApiException(
            errorCode: ApiErrorCode.notFound,
            customMessage: 'Kayıt bulunamadı',
          );
        }
        return result;
      },
      customMessage: 'Kayıt bulunamadı',
    );
  }

  @override
  Future<T> create(T model) async {
    return _handleApiError(
      operation: () async {
        final response = await client.post(
          url,
          headers: {
            ...?header,
            'Content-Type': 'application/json',
          },
          body: json.encode(toJson(model)),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          await _invalidateCache('getAll');

          final decodedBody = json.decode(response.body);
          return fromJson(decodedBody['data'] ?? decodedBody);
        }

        throw HttpCustomException(
          message: response.body,
          statusCode: response.statusCode,
          stackTrace: StackTrace.current,
          name: 'Smart Api Service',
        );
      },
      customMessage: 'Kayıt oluşturulamadı',
    );
  }

  @override
  Future<T> updateById(dynamic id, T model) async {
    return _handleApiError(
      operation: () async {
        final response = await client.put(
          urlWithId(id),
          headers: {
            ...?header,
            'Content-Type': 'application/json',
          },
          body: json.encode(toJson(model)),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          await Future.wait([
            _invalidateCache('getAll'),
            _invalidateCache('getById', {'id': id}),
          ]);

          final decodedBody = json.decode(response.body);
          return fromJson(decodedBody['data'] ?? decodedBody);
        }

        throw HttpCustomException(
          message: response.body,
          statusCode: response.statusCode,
          stackTrace: StackTrace.current,
          name: 'Smart Api Service',
        );
      },
      customMessage: 'Kayıt güncellenemedi',
    );
  }

  @override
  Future<bool> deleteById(dynamic id) async {
    return _handleApiError(
      operation: () async {
        final response = await client.delete(
          urlWithId(id),
          headers: header,
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          await Future.wait([
            _invalidateCache('getAll'),
            _invalidateCache('getById', {'id': id}),
          ]);
          return true;
        }

        throw HttpCustomException(
          message: response.body,
          statusCode: response.statusCode,
          stackTrace: StackTrace.current,
          name: 'Smart Api Service',
        );
      },
      customMessage: 'Kayıt silinemedi',
    );
  }

  // Pagination support
  Future<PaginatedResponse<T>> getPaginated({
    required int page,
    required int pageSize,
    Map<String, dynamic>? filters,
    CachePriority priority = CachePriority.high,
  }) async {
    return _handleApiError(
      operation: () async {
        final cacheKey = _generateCacheKey('getPaginated', {
          'page': page,
          'pageSize': pageSize,
          ...?filters,
        });

        return await _cacheManager.getOrFetch<PaginatedResponse<T>>(
          cacheKey,
          () => _fetchPaginated(page, pageSize, filters),
          priority: priority,
        );
      },
      customMessage: 'Sayfalı veri alınamadı',
    );
  }

  // Private helper methods
  Future<List<T>> _fetchAll() async {
    try {
      final response = await client.get(url, headers: header);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedBody = json.decode(response.body);
        final data = decodedBody['data'] ?? decodedBody;

        if (data is List) {
          return data.map((item) {
            try {
              final processedItem = Map<String, dynamic>.from(item);
              // Sadece String, num, bool ve null değerleri kabul et
              processedItem.forEach((key, value) {
                if (value is List) {
                  if (value.isEmpty) {
                    processedItem[key] = null;
                  } else {
                    processedItem[key] = value.first.toString();
                  }
                } else if (!(value is String ||
                    value is num ||
                    value is bool ||
                    value == null)) {
                  processedItem[key] = value.toString();
                }
              });
              return fromJson(processedItem);
            } catch (e) {
              debugPrint('Item processing error: $e for item: $item');
              rethrow;
            }
          }).toList();
        } else if (data is Map) {
          final processedData = Map<String, dynamic>.from(data);
          processedData.forEach((key, value) {
            if (value is List) {
              if (value.isEmpty) {
                processedData[key] = null;
              } else {
                processedData[key] = value.first.toString();
              }
            } else if (!(value is String ||
                value is num ||
                value is bool ||
                value == null)) {
              processedData[key] = value.toString();
            }
          });
          return [fromJson(processedData)];
        }
        throw Exception('Invalid response format');
      }

      throw HttpCustomException(
        message: 'Failed to get all data',
        statusCode: response.statusCode,
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      debugPrint('Error in _fetchAll: $e');
      throw _handleError(e, 'Failed to get all data');
    }
  }

  Future<T?> _fetchById(dynamic id) async {
    try {
      final response = await client.get(urlWithId(id), headers: header);
      return _handleResponse(response);
    } catch (e) {
      _handleError(e, 'Failed to get data by id');
    }
  }

  Future<PaginatedResponse<T>> _fetchPaginated(
    int page,
    int pageSize,
    Map<String, dynamic>? filters,
  ) async {
    try {
      final response = await client.get(
        endPoint as Uri,
        headers: header,
      );

      if (kDebugMode) {
        print('Smart API Service - GetPaginated');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode,
          stackTrace: StackTrace.current,
        );
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decodedBody = json.decode(response.body);
        if (kDebugMode) {
          print('Decoded Body Structure: ${decodedBody.runtimeType}');
          print('Decoded Body: $decodedBody');
        }

        // API response yapısına göre kontrol
        if (decodedBody is List) {
          final items = decodedBody
              .map((item) => fromJson(item as Map<String, dynamic>))
              .toList();
          return PaginatedResponse<T>(
            items: items,
            totalCount: items.length,
            currentPage: page,
            pageSize: pageSize,
            hasMore: items.length >= pageSize,
          );
        } else if (decodedBody is Map<String, dynamic>) {
          if (decodedBody.containsKey('data')) {
            final List<dynamic> data = decodedBody['data'] as List;
            final items = data
                .map((item) => fromJson(item as Map<String, dynamic>))
                .toList();
            return PaginatedResponse<T>(
              items: items,
              totalCount: items.length,
              currentPage: page,
              pageSize: pageSize,
              hasMore: items.length >= pageSize,
            );
          } else {
            return PaginatedResponse.fromJson(
              decodedBody,
              (json) => fromJson(json),
            );
          }
        } else {
          throw HttpCustomException(
            message: 'Unexpected response format',
            statusCode: response.statusCode,
            stackTrace: StackTrace.current,
            name: 'Smart Api Service',
            operation: 'Fetch Paginated',
            type: 'Format',
            metaData: {
              'response': response.toString(),
              'decodedBodyType': decodedBody.runtimeType.toString(),
            },
          );
        }
      } else {
        throw HttpCustomException(
          message: response.body,
          statusCode: response.statusCode,
          stackTrace: StackTrace.current,
          name: 'Smart Api Service',
          operation: 'Fetch Paginated',
          type: 'Check',
          metaData: {
            'response': response.toString(),
          },
        );
      }
    } catch (e) {
      throw handlerException(e, message: 'Failed to get paginated data');
    }
  }

  String _generateCacheKey(String operation, [Map<String, dynamic>? params]) {
    try {
      final key = '${T.toString()}_${endPoint}_$operation';
      if (params?.isNotEmpty ?? false) {
        return '${key}_${json.encode(params)}';
      }
      return key;
    } catch (e) {
      if (kDebugMode) {
        print('Error in _generateCacheKey: $e');
      }
      return '';
    }
  }

  // Ortak response işleme metodu
  T _handleResponse(http.Response response) {
    if (response.statusCode == 401) {
      throw UnauthorizedException(
        message: 'Token has expired',
        statusCode: response.statusCode,
        stackTrace: StackTrace.current,
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodedBody = json.decode(response.body);
      if (decodedBody is Map<String, dynamic> &&
          decodedBody.containsKey('data')) {
        return fromJson(decodedBody['data']);
      }
      throw HttpCustomException(
        message: 'Unexpected response format',
        statusCode: response.statusCode,
        stackTrace: StackTrace.current,
        name: 'Smart Api Service',
      );
    }

    throw HttpCustomException(
      message: response.body,
      statusCode: response.statusCode,
      stackTrace: StackTrace.current,
      name: 'Smart Api Service',
    );
  }

  // Ortak hata işleme metodu
  Never _handleError(dynamic error, String message) {
    if (error is UnauthorizedException || error is HttpCustomException) {
      throw error;
    }
    throw HttpCustomException(
      message: message,
      statusCode: 500,
      stackTrace: StackTrace.current,
      name: 'Smart Api Service',
      metaData: {'error': error.toString()},
    );
  }

  // Cache invalidation için yardımcı metod
  Future<void> _invalidateCache(String operation,
      [Map<String, dynamic>? params]) async {
    final cacheKey = _generateCacheKey(operation, params);
    await _cacheManager.remove(cacheKey);
  }
}
