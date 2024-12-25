import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ModulesServices extends BaseApiService<Modules> with BaseServiceMixin {
  ModulesServices({super.endPoint = '/modules'});

  @override
  Future<List<Modules>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('Modules Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<Modules>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Modules.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ModulesServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Modules> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('Modules Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Modules>.fromJson(
        json.decode(response.body),
        (data) => Modules.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ModulesServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Modules> create(Modules model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('Modules Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Modules>.fromJson(
        json.decode(response.body),
        (data) => Modules.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ModulesServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Modules> update(int id, Modules model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('Modules Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Modules>.fromJson(
        json.decode(response.body),
        (data) => Modules.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ModulesServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Modules Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ModulesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      
      if (kDebugMode) print('ModulesServices Storage initialized');
      
      final token = await super.storage?.read(BearerTokenKey);
      
      super.client = stockTrackerApiClient(token);
      
      if (kDebugMode) print('ModulesServices Client initialized');
      
    } catch (e) {
      if (kDebugMode) print('ModulesServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      
      if (kDebugMode) print('ModulesServices Client disposed');
      
      super.storage = null;
      
      if (kDebugMode) print('ModulesServices Storage disposed');
      
    } catch (e) {
      if (kDebugMode) print('ModulesServices Dispose Error: $e');
      rethrow;
    }
  }
}