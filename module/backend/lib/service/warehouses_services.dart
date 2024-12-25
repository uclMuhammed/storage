import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class WarehousesServices extends BaseApiService<Warehouses>
    with BaseServiceMixin {
  WarehousesServices({super.endPoint = '/warehouses'});

  @override
  Future<List<Warehouses>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('Warehouse Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<Warehouses>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Warehouses.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('WarehousesServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Warehouses> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('Warehouse Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Warehouses>.fromJson(
        json.decode(response.body),
        (data) => Warehouses.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('WarehousesServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Warehouses> create(Warehouses model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('Warehouse Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Warehouses>.fromJson(
        json.decode(response.body),
        (data) => Warehouses.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('WarehousesServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Warehouses> update(int id, Warehouses model) async {
    try {
      final response = await client?.putById(
        super.endPoint,
        body: model.toJson(),
        id: id,
      );

      if (kDebugMode) {
        print('Warehouse Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Warehouses>.fromJson(
        json.decode(response.body),
        (data) => Warehouses.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('WarehousesServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Warehouses Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('WarehousesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('WarehousesServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('WarehousesServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('WarehousesServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('WarehousesServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('WarehousesServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('WarehousesServices Dispose Error: $e');
      rethrow;
    }
  }
}
