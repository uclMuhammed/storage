import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ProductUnitsServices extends BaseApiService<ProductUnits>
    with BaseServiceMixin {
  ProductUnitsServices({super.endPoint = '/productUnits'});

  @override
  Future<List<ProductUnits>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('ProductUnit Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<ProductUnits>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => ProductUnits.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductUnitsServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductUnits> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('ProductUnit Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProductUnits>.fromJson(
        json.decode(response.body),
        (data) => ProductUnits.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductUnitsServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductUnits> create(ProductUnits model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('ProductUnit Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProductUnits>.fromJson(
        json.decode(response.body),
        (data) => ProductUnits.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductUnitsServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductUnits> update(int id, ProductUnits model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('ProductUnit Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProductUnits>.fromJson(
        json.decode(response.body),
        (data) => ProductUnits.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductUnitsServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Product Units Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('ProductUnitsService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('ProductUnitsServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('ProductUnitsServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('ProductUnitsServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('ProductUnitsServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('ProductUnitsServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('ProductUnitsServices Dispose Error: $e');
      rethrow;
    }
  }
}
