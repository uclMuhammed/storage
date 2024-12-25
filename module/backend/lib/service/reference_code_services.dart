import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ReferenceCodeServices extends BaseApiService<ReferenceCode>
    with BaseServiceMixin {
  ReferenceCodeServices({super.endPoint = '/referenceCode'});

  @override
  Future<List<ReferenceCode>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('ReferenceCode Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<ReferenceCode>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => ReferenceCode.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<ReferenceCode> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('ReferenceCode Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ReferenceCode>.fromJson(
        json.decode(response.body),
        (data) => ReferenceCode.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeServices Get By Id Error: $e');
      rethrow;
    }
  }

  @override
  Future<ReferenceCode> create(ReferenceCode model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('ReferenceCode Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ReferenceCode>.fromJson(
        json.decode(response.body),
        (data) => ReferenceCode.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<ReferenceCode> update(int id, ReferenceCode model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('ReferenceCode Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ReferenceCode>.fromJson(
        json.decode(response.body),
        (data) => ReferenceCode.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Reference Code Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data is bool,
      );
      if (apiResponse.status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('ReferenceCodeServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('ReferenceCodeServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('ReferenceCodeServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('ReferenceCodeServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('ReferenceCodeServices Dispose Error: $e');
      rethrow;
    }
  }
}
