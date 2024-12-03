import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:flutter/foundation.dart';

import '../base/api_service.dart';
import '../base/models.dart';
import '../const/keys.dart';
import '../implement/http_client.dart';
import '../models/response/api_response.dart';
import '../models/response/info_response.dart';
import '../storage/shared_preferences.dart';

class GenericApiService<T extends BaseModel<T>> extends BaseApiService<T> {
  final T Function(Map<String, dynamic>) fromJson;

  GenericApiService({
    required super.endPoint,
    required this.fromJson,
  });

  @override
  Future<List<T>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('Raw API Response: ${response.body}');
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final data = responseData['data'];

      // Hata kontrolü
      if (data is List && data.isNotEmpty && data[0] is Map<String, dynamic>) {
        // InfoResponse kontrolü (hata durumu)
        if (data[0].containsKey('HasError') && data[0]['HasError'] == true) {
          if (kDebugMode) {
            print('Service Error: ${data[0]['Message']}');
          }
          return []; // Hata durumunda boş liste dön
        }

        // Normal veri dönüşü
        return data.map((item) => fromJson(item as Map<String, dynamic>)).toList();
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        print('Service GetAll Error: $e');
      }
      return [];
    }
  }

  @override
  Future<T> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (response is Http.Response) {
        if (kDebugMode) {
          print('${T.toString()} Service GetById Response Body: ${response.body}');
        }

        final jsonData = jsonDecode(response.body);
        final apiResponse = ApiResponse<T>.fromJson(
          jsonData,
          // Yanıt bir liste içinde geliyorsa ilk elemanı al
          (data) => fromJson((data as List).first),
        );

        return apiResponse.data;
      }
      throw Exception('Invalid response type');
    } catch (e) {
      if (kDebugMode) print('${T.toString()} Service GetById Error: $e');
      rethrow;
    }
  }

  // generic_api_service.dart
  @override
  Future<T> create(T model) async {
    try {
      final response = await client?.post(
        endPoint,
        body: model.toJson(),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Hata kontrolü
      if (responseData['data'] is List && responseData['data'].isNotEmpty) {
        final firstItem = responseData['data'][0];
        if (firstItem is Map<String, dynamic> && firstItem['HasError'] == true) {
          if (firstItem['Message'].toString().contains('UNIQUE KEY constraint')) {
            throw Exception('Bu kayıt zaten mevcut');
          }
          throw Exception(firstItem['Message']);
        }
      }

      // Başarılı yanıt
      if (responseData['status'] == 'Success') {
        final apiResponse = ApiResponse<T>.fromJson(
          responseData,
          (data) => fromJson(data[0]),
        );
        return apiResponse.data;
      } else {
        throw Exception('İşlem başarısız');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Create Error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<T> update(int id, T model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('Update Response Body: ${response.body}');
      }

      final apiResponse = ApiResponse<T>.fromJson(
        jsonDecode(response.body),
        (data) => model.fromJson(data[0]), // Liste içindeki ilk elemanı al
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await client?.deleteById(endPoint, id: id);

      if (response is Http.Response) {
        if (kDebugMode) {
          print('${T.toString()} Service Delete Response Body: ${response.body}');
        }

        final decodedResponse = jsonDecode(response.body);
        final infoResponse = InfoResponse.fromJson(decodedResponse['data'][0]);

        return !infoResponse.hasError;
      }
      return false;
    } catch (e) {
      if (kDebugMode) print('${T.toString()} Service Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      storage = await SharedPreferencesService.getInstance();
      if (kDebugMode) print('${T.toString()} Service Storage initialized');

      final token = await storage?.read(BearerTokenKey);
      client = stockTrackerApiClient(token);
      if (kDebugMode) print('${T.toString()} Service Client initialized');
    } catch (e) {
      if (kDebugMode) print('${T.toString()} Service Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      client = null;
      if (kDebugMode) print('${T.toString()} Service Client disposed');

      storage = null;
      if (kDebugMode) print('${T.toString()} Service Storage disposed');
    } catch (e) {
      if (kDebugMode) print('${T.toString()} Service Dispose Error: $e');
      rethrow;
    }
  }
}
