import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class PlansServices extends BaseApiService<Plans> with BaseServiceMixin {
  PlansServices({super.endPoint = '/plans'});

  @override
  Future<List<Plans>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('Plans Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<Plans>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Plans.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('PlansServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Plans> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('Plans Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Plans>.fromJson(
        json.decode(response.body),
        (data) => Plans.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('PlansServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Plans> create(Plans model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('Plans Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Plans>.fromJson(
        json.decode(response.body),
        (data) => Plans.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('PlansServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Plans> update(int id, Plans model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('Plans Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Plans>.fromJson(
        json.decode(response.body),
        (data) => Plans.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('PlansServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Plans Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('PlansService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      
      if (kDebugMode) print('PlansServices Storage initialized');
      
      final token = await super.storage?.read(BearerTokenKey);
      
      super.client = stockTrackerApiClient(token);
      
      if (kDebugMode) print('PlansServices Client initialized');
      
    } catch (e) {
      if (kDebugMode) print('PlansServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      
      if (kDebugMode) print('PlansServices Client disposed');
      
      super.storage = null;
      
      if (kDebugMode) print('PlansServices Storage disposed');
      
    } catch (e) {
      if (kDebugMode) print('PlansServices Dispose Error: $e');
      rethrow;
    }
  }
}