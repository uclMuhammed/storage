import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../base/api_service.dart';
import '../base/base_service_mixin.dart';
import '../implement/http_client.dart';

class ProductMovementService extends BaseApiService<ProductMovement> with BaseServiceMixin {
  ProductMovementService({super.endPoint = '/productMovement'});

  @override
  Future<List<ProductMovement>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('Product Movement Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<ProductMovement>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => ProductMovement.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductMovementService Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductMovement> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('Product Movement Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<ProductMovement>.fromJson(
        json.decode(response.body),
        (data) => ProductMovement.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductMovementService GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductMovement> create(ProductMovement model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('Product Movement Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<ProductMovement>.fromJson(
        json.decode(response.body),
        (data) => ProductMovement.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductMovementService Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductMovement> update(int id, ProductMovement model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('Product Movement Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<ProductMovement>.fromJson(
        json.decode(response.body),
        (data) => ProductMovement.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductMovementService Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Product Movement Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductMovementService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      //
      if (kDebugMode) print('ProductMovementService Storage initialized');
      //
      final token = await super.storage?.read(BearerTokenKey);
      //
      super.client = stockTrackerApiClient(token);
      //
      if (kDebugMode) print('ProductMovementService Client initialized');
      //
    } catch (e) {
      if (kDebugMode) print('ProductMovementService Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      //
      if (kDebugMode) print('ProductMovementService Client disposed');
      //
      super.storage = null;
      //
      if (kDebugMode) print('ProductMovementService Storage disposed');
      //
    } catch (e) {
      if (kDebugMode) print('ProductMovementService Dispose Error: $e');
      rethrow;
    }
  }
}