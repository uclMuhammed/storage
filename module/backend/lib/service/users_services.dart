import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UsersServices extends BaseApiService<Users> with BaseServiceMixin {
  UsersServices({super.endPoint = '/users'});

  @override
  Future<List<Users>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('User Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<Users>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Users.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('UsersServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Users> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('User Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Users>.fromJson(
        json.decode(response.body),
        (data) => Users.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('UsersServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Users> create(Users model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('User Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Users>.fromJson(
        json.decode(response.body),
        (data) => Users.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('UsersServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Users> update(int id, Users model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('User Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Users>.fromJson(
        json.decode(response.body),
        (data) => Users.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('UsersServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Users Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('UsersService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      
      if (kDebugMode) print('UsersServices Storage initialized');
      
      final token = await super.storage?.read(BearerTokenKey);
      
      super.client = stockTrackerApiClient(token);
      
      if (kDebugMode) print('UsersServices Client initialized');
      
    } catch (e) {
      if (kDebugMode) print('UsersServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      
      if (kDebugMode) print('UsersServices Client disposed');
      
      super.storage = null;
      
      if (kDebugMode) print('UsersServices Storage disposed');
      
    } catch (e) {
      if (kDebugMode) print('UsersServices Dispose Error: $e');
      rethrow;
    }
  }
}