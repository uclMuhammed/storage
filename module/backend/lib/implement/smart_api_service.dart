import 'dart:convert';
import 'package:dio/dio.dart';
import '../abstract/index.dart';
import 'smart_cache_manager.dart';
import '../models/paginated_response.dart';
import '../exception/unauthorized_exception.dart';
import 'package:flutter/foundation.dart';
import '../exception/http_custom_exception.dart';

class SmartApiService<T extends IModel> extends IApiService<T> {
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final SmartCacheManager _cacheManager;
  final Dio _dio;

  SmartApiService({
    required this.fromJson,
    required this.toJson,
    required super.header,
    required super.endPoint,
    required super.baseUrl,
  })  : _cacheManager = SmartCacheManager(),
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
        ));

  // CRUD Operations with Cache
  @override
  Future<List<T>> getAll({
    Map<String, dynamic>? queryParameters,
    CachePriority priority = CachePriority.medium,
  }) async {
    try {
      final cacheKey = _generateCacheKey('getAll', queryParameters);

      return await _cacheManager.getOrFetch<List<T>>(
        cacheKey,
        () => _fetchAll(queryParameters),
        priority: priority,
      );
    } catch (e) {
      throw handlerException(e, message: 'Failed to get all data');
    }
  }

  @override
  Future<T> getById(
    dynamic id, {
    CachePriority priority = CachePriority.high,
  }) async {
    try {
      final cacheKey = _generateCacheKey('getById', {'id': id});

      return (await _cacheManager.getOrFetch<T>(
        cacheKey,
        () async => (await _fetchById(id))!,
        priority: priority,
      ));
    } catch (e) {
      throw handlerException(e, message: 'Failed to get data by id');
    }
  }

  @override
  Future<T> create(T model) async {
    try {
      final response = await _dio.post(
        endPoint,
        data: toJson(model),
        options: Options(headers: header),
      );

      if (kDebugMode) {
        print('Smart API Service - Create');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode ?? 401,
          stackTrace: StackTrace.current,
        );
      }

      final decodedBody = response.data;
      final createdEntity = fromJson(
          decodedBody is Map<String, dynamic> && decodedBody.containsKey('data')
              ? decodedBody['data'] as Map<String, dynamic>
              : decodedBody as Map<String, dynamic>);

      // Tüm ilgili cache'leri temizle
      await _cacheManager.invalidate(_generateCacheKey('getAll'));
      await _cacheManager.invalidate(_generateCacheKey('getPaginated'));

      // Yeni veriyi cache'e ekle
      final allCacheKey = _generateCacheKey('getAll');
      final existingData = await _cacheManager.get<List<T>>(allCacheKey);
      if (existingData != null) {
        await _cacheManager.set(allCacheKey, [createdEntity, ...existingData]);
      }

      return createdEntity;
    } catch (e) {
      throw handlerException(e, message: 'Failed to create data');
    }
  }

  @override
  Future<T> updateById(dynamic id, T model) async {
    try {
      final response = await _dio.put(
        '$endPoint/$id',
        data: toJson(model),
        options: Options(headers: header),
      );

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode ?? 401,
          stackTrace: StackTrace.current,
        );
      }

      final decodedBody = response.data;
      final updatedEntity =
          fromJson(decodedBody['data'] as Map<String, dynamic>);

      // Invalidate related caches
      await _cacheManager.invalidate(_generateCacheKey('getAll'));
      await _cacheManager.invalidate(_generateCacheKey('getById', {'id': id}));

      return updatedEntity;
    } catch (e) {
      throw handlerException(e, message: 'Failed to update data by id');
    }
  }

  @override
  Future<bool> deleteById(int id) async {
    try {
      final response = await _dio.delete(
        '$endPoint/$id',
        options: Options(headers: header),
      );

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode ?? 401,
          stackTrace: StackTrace.current,
        );
      }

      // Invalidate related caches
      await _cacheManager.invalidate(_generateCacheKey('getAll'));
      return true;
    } catch (e) {
      throw handlerException(e, message: 'Failed to delete data by id');
    }
  }

  // Pagination support
  Future<PaginatedResponse<T>> getPaginated({
    required int page,
    required int pageSize,
    Map<String, dynamic>? filters,
    CachePriority priority = CachePriority.high,
  }) async {
    try {
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
    } catch (e) {
      throw handlerException(e, message: 'Failed to get paginated data');
    }
  }

  // Search support
  Future<List<T>> search(
    String query, {
    CachePriority priority = CachePriority.critical,
  }) async {
    try {
      final cacheKey = _generateCacheKey('search', {'query': query});

      return await _cacheManager.getOrFetch<List<T>>(
        cacheKey,
        () => _fetchSearch(query),
        priority: priority,
      );
    } catch (e) {
      throw handlerException(e, message: 'Failed to search data');
    }
  }

  // Private helper methods
  Future<List<T>> _fetchAll(Map<String, dynamic>? queryParameters) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: header),
      );

      if (kDebugMode) {
        print('Smart API Service - GetAll');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode ?? 401,
          stackTrace: StackTrace.current,
        );
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final decodedBody = response.data;
        if (kDebugMode) {
          print('Decoded Body Structure: ${decodedBody.runtimeType}');
          print('Decoded Body: $decodedBody');
        }

        // API response yapısına göre kontrol
        if (decodedBody is Map<String, dynamic>) {
          if (decodedBody.containsKey('data')) {
            final List<dynamic> data = decodedBody['data'] as List;
            return data
                .map((e) => fromJson(e as Map<String, dynamic>))
                .toList();
          } else {
            // Direkt liste dönüyorsa
            return (decodedBody as List)
                .map((e) => fromJson(e as Map<String, dynamic>))
                .toList();
          }
        } else if (decodedBody is List) {
          // Direkt liste dönüyorsa
          return decodedBody
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw HttpCustomException(
            message: 'Unexpected response format',
            statusCode: response.statusCode ?? 500,
            stackTrace: StackTrace.current,
            name: 'Smart Api Service',
            operation: 'Fetch All',
            type: 'Format',
            metaData: {
              'response': response.toString(),
              'decodedBodyType': decodedBody.runtimeType.toString(),
            },
          );
        }
      } else {
        throw HttpCustomException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
          stackTrace: StackTrace.current,
          name: 'Smart Api Service',
          operation: 'Fetch All',
          type: 'Check',
          metaData: {
            'response': response.toString(),
          },
        );
      }
    } catch (e) {
      throw handlerException(e, message: 'Failed to get all data');
    }
  }

  Future<T?> _fetchById(dynamic id) async {
    try {
      final response = await _dio.get(
        '$endPoint/$id',
        options: Options(headers: header),
      );

      if (kDebugMode) {
        print('Smart API Service - GetById');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('Response Headers: ${response.headers}');
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode ?? 401,
          stackTrace: StackTrace.current,
        );
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final decodedBody = response.data;
        if (kDebugMode) {
          print('Decoded Body: $decodedBody');
        }

        return fromJson(decodedBody['data'] as Map<String, dynamic>);
      } else {
        throw HttpCustomException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
          stackTrace: StackTrace.current,
          name: 'Smart Api Service',
          operation: 'Fetch By Id',
          type: 'Check',
          metaData: {
            'response': response.toString(),
          },
        );
      }
    } catch (e) {
      throw handlerException(e, message: 'Failed to get data by id');
    }
  }

  Future<PaginatedResponse<T>> _fetchPaginated(
    int page,
    int pageSize,
    Map<String, dynamic>? filters,
  ) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (filters != null) ...filters,
        },
        options: Options(headers: header),
      );

      if (kDebugMode) {
        print('Smart API Service - GetPaginated');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }

      if (response.statusCode == 401) {
        throw UnauthorizedException(
          message: 'Token has expired',
          statusCode: response.statusCode ?? 401,
          stackTrace: StackTrace.current,
        );
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final decodedBody = response.data;
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
            statusCode: response.statusCode ?? 500,
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
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
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

  Future<List<T>> _fetchSearch(String query) async {
    try {
      final response = await _dio.get(
        '$endPoint/search',
        queryParameters: {'q': query},
      );

      return (response.data as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw handlerException(e, message: 'Failed to search data');
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
}
