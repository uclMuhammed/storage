import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';

import '../base/api_service.dart';
import '../const/keys.dart';
import '../implement/http_client.dart';
import '../storage/shared_preferences.dart';

class BrandsService extends BaseApiService<Brands> {
  BrandsService({super.endPoint = '/brands'});

  @override
  Future<List<Brands>> getAll() async {
    try {
      final response = await super.client?.getAll(endPoint);
      if (kDebugMode) {
        print(response.toString());
      }
      final apiResponse = ApiResponse<List<Brands>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Brands.fromJson(e)).toList(),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('BrandsService Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Brands> getById(int id) async {
    try {
      //
      final response = await super.client?.getById(super.endPoint, id: id);
      //
      if (kDebugMode) {
        print('Brands Service GetById Response Body : ${response.body}');
      }
      //
      final apiResponse = ApiResponse<Brands>.fromJson(
        json.decode(response.body),
        (data) => Brands.fromJson(data as Map<String, dynamic>),
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('BrandsService Get By Id Error: $e');
      rethrow;
    }
  }

  @override
  Future<Brands> create(Brands model) async {
    try {
      final response =
          await super.client?.post(super.endPoint, body: model.toJson());
      if (kDebugMode) {
        print('Brands Service Create Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<Brands>.fromJson(
        json.decode(response.body),
        (data) => Brands.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('BrandsService Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Brands> update(int id, Brands model) async {
    try {
      final response = await super
          .client
          ?.putById(super.endPoint, id: id, body: model.toJson());
      if (kDebugMode) {
        print('Brands Service Update Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<Brands>.fromJson(
        json.decode(response.body),
        (data) => Brands.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('BrandsService Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(super.endPoint, id: id);
      final apiResponse = ApiResponse.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      if (apiResponse.status) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) print('BrandsService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      //
      if (kDebugMode) print('BrandsService Storage İnitialized: $storage');
      //
      final token = await super.storage?.read(BearerTokenKey);
      //
      super.client = stockTrackerApiClient(token);
      //
      if (kDebugMode) print('BrandsService Client İnitialized: $client');
      //
    } catch (e) {
      if (kDebugMode) print('BrandsService Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      //
      if (kDebugMode) print('BrandsService Client disposed');
      //
      super.storage = null;
      //
      if (kDebugMode) print('BrandsService Storage disposed');
      //
    } catch (e) {
      if (kDebugMode) print('BrandsService Dispose Error: $e');
      rethrow;
    }
  }
}
