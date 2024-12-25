import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class RolesServices extends BaseApiService<Roles> with BaseServiceMixin {
  RolesServices({super.endPoint = '/roles'});

  @override
  Future<List<Roles>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('Role Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<Roles>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Roles.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RolesServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Roles> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('Role Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Roles>.fromJson(
        json.decode(response.body),
        (data) => Roles.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RolesServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Roles> create(Roles model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('Role Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Roles>.fromJson(
        json.decode(response.body),
        (data) => Roles.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RolesServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Roles> update(int id, Roles model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('Role Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Roles>.fromJson(
        json.decode(response.body),
        (data) => Roles.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RolesServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Roles Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('RolesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('RolesServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('RolesServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('RolesServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('RolesServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('RolesServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('RolesServices Dispose Error: $e');
      rethrow;
    }
  }
}
