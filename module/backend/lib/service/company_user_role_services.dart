import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CompanyUserRoleServices extends BaseApiService<CompanyUserRole>
    with BaseServiceMixin {
  CompanyUserRoleServices({super.endPoint = '/companyUserRoles'});

  @override
  Future<List<CompanyUserRole>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print(
            'CompanyUserRole Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<CompanyUserRole>>.fromJson(
        json.decode(response.body),
        (data) =>
            (data as List).map((e) => CompanyUserRole.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserRole> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print(
            'CompanyUserRole Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<CompanyUserRole>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserRole.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserRole> create(CompanyUserRole model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print(
            'CompanyUserRole Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<CompanyUserRole>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserRole.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserRole> update(int id, CompanyUserRole model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print(
            'CompanyUserRole Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<CompanyUserRole>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserRole.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print(
            'Company User Role Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('CompanyUserRoleServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('CompanyUserRoleServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('CompanyUserRoleServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('CompanyUserRoleServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('CompanyUserRoleServices Dispose Error: $e');
      rethrow;
    }
  }
}
