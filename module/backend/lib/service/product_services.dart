import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ProductServices extends BaseApiService<Products> with BaseServiceMixin {
  ProductServices({super.endPoint = '/products'});

  @override
  Future<List<Products>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      if (kDebugMode) {
        print('Product Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<Products>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Products.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Products> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('Product Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Products>.fromJson(
        json.decode(response.body),
        (data) => Products.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Products> create(Products model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('Product Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Products>.fromJson(
        json.decode(response.body),
        (data) => Products.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Products> update(int id, Products model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('Product Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Products>.fromJson(
        json.decode(response.body),
        (data) => Products.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await client?.deleteById(endPoint, id: id);

      if (kDebugMode) {
        print('Product Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('ProductService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('ProductServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('ProductServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('ProductServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('ProductServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('ProductServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('ProductServices Dispose Error: $e');
      rethrow;
    }
  }
}
