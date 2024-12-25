import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class TaxRateServices extends BaseApiService<TaxRate> with BaseServiceMixin {
  TaxRateServices({super.endPoint = '/taxRate'});

  @override
  Future<List<TaxRate>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('TaxRate Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<TaxRate>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => TaxRate.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('TaxRateServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<TaxRate> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('TaxRate Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<TaxRate>.fromJson(
        json.decode(response.body),
        (data) => TaxRate.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('TaxRateServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<TaxRate> create(TaxRate model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('TaxRate Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<TaxRate>.fromJson(
        json.decode(response.body),
        (data) => TaxRate.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('TaxRateServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<TaxRate> update(int id, TaxRate model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('TaxRate Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<TaxRate>.fromJson(
        json.decode(response.body),
        (data) => TaxRate.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('TaxRateServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Tax Rate Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('TaxRateService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('TaxRateServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('TaxRateServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('TaxRateServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('TaxRateServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('TaxRateServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('TaxRateServices Dispose Error: $e');
      rethrow;
    }
  }
}
