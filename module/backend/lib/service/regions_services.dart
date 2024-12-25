import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class RegionsServices extends BaseApiService<Regions> with BaseServiceMixin {
  RegionsServices({super.endPoint = '/regions'});

  @override
  Future<List<Regions>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('Region Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<Regions>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Regions.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RegionsServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Regions> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('Region Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Regions>.fromJson(
        json.decode(response.body),
        (data) => Regions.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RegionsServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Regions> create(Regions model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('Region Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Regions>.fromJson(
        json.decode(response.body),
        (data) => Regions.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RegionsServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Regions> update(int id, Regions model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('Region Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Regions>.fromJson(
        json.decode(response.body),
        (data) => Regions.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RegionsServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Regions Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('RegionsService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('RegionsServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('RegionsServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('RegionsServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('RegionsServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('RegionsServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('RegionsServices Dispose Error: $e');
      rethrow;
    }
  }
}
