import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ProjectCodeServices extends BaseApiService<ProjectCode>
    with BaseServiceMixin {
  ProjectCodeServices({super.endPoint = '/projectCode'});

  @override
  Future<List<ProjectCode>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);

      if (kDebugMode) {
        print('ProjectCode Service GetAll Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<List<ProjectCode>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => ProjectCode.fromJson(e)).toList(),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProjectCodeServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProjectCode> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);

      if (kDebugMode) {
        print('ProjectCode Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProjectCode>.fromJson(
        json.decode(response.body),
        (data) => ProjectCode.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProjectCodeServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProjectCode> create(ProjectCode model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());

      if (kDebugMode) {
        print('ProjectCode Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProjectCode>.fromJson(
        json.decode(response.body),
        (data) => ProjectCode.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProjectCodeServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProjectCode> update(int id, ProjectCode model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('ProjectCode Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<ProjectCode>.fromJson(
        json.decode(response.body),
        (data) => ProjectCode.fromJson(data as Map<String, dynamic>),
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('ProjectCodeServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Project Code Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('ProjectCodeService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) print('ProjectCodeServices Storage initialized');

      final token = await super.storage?.read(BearerTokenKey);

      super.client = stockTrackerApiClient(token);

      if (kDebugMode) print('ProjectCodeServices Client initialized');
    } catch (e) {
      if (kDebugMode) print('ProjectCodeServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;

      if (kDebugMode) print('ProjectCodeServices Client disposed');

      super.storage = null;

      if (kDebugMode) print('ProjectCodeServices Storage disposed');
    } catch (e) {
      if (kDebugMode) print('ProjectCodeServices Dispose Error: $e');
      rethrow;
    }
  }
}
