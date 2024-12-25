import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/models/product_stats.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ProductStatsServices extends BaseApiService<ProductStats>
    with BaseServiceMixin {
  ProductStatsServices({super.endPoint = '/productStats'});
/*

  int? _productId;

  void setProductId(int? productId) {
    _productId = productId;
  }

  String get _endPoint => super.endPoint;

  String _getEndPoint([int? productStatsId]) {
    if (_productId == null) {
      throw Exception('Product ID must be set before making any requests');
    }

    if (productStatsId != null) {
      return '$_endPoint/$_productId/$productStatsId';
    }
    return '$_endPoint/$_productId';
  }
 */
  @override
  Future<List<ProductStats>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('ProductStats Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<ProductStats>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => ProductStats.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductStatsServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductStats> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('ProductStats Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProductStats>.fromJson(
        json.decode(response.body),
        (data) => ProductStats.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductStatsServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductStats> create(ProductStats model) async {
    try {
      final response = await client?.post(super.endPoint, body: model.toJson());

      if (kDebugMode) {
        print('ProductStats Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProductStats>.fromJson(
        json.decode(response.body),
        (data) => ProductStats.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductStatsServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProductStats> update(int id, ProductStats model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('ProductStats Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProductStats>.fromJson(
        json.decode(response.body),
        (data) => ProductStats.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductStatsServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Product Stats Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProductStatsService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('ProductStatsServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('ProductStatsServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('ProductStatsServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('ProductStatsServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('ProductStatsServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('ProductStatsServices Dispose Error: $e');
      rethrow;
    }
  }
}
