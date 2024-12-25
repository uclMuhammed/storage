import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SuppliersServices extends BaseApiService<Suppliers>
    with BaseServiceMixin {
  SuppliersServices({super.endPoint = '/suppliers'});

  @override
  Future<List<Suppliers>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('Supplier Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<Suppliers>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Suppliers.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('SuppliersServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Suppliers> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('Supplier Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Suppliers>.fromJson(
        json.decode(response.body),
        (data) => Suppliers.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('SuppliersServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Suppliers> create(Suppliers model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('Supplier Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Suppliers>.fromJson(
        json.decode(response.body),
        (data) => Suppliers.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('SuppliersServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Suppliers> update(int id, Suppliers model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('Supplier Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Suppliers>.fromJson(
        json.decode(response.body),
        (data) => Suppliers.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('SuppliersServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Suppliers Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('SuppliersService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('SuppliersServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('SuppliersServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('SuppliersServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('SuppliersServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('SuppliersServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('SuppliersServices Dispose Error: $e');
      rethrow;
    }
  }
}
