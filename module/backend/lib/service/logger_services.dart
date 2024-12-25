import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class LoggerServices extends BaseApiService<Logger> with BaseServiceMixin {
  LoggerServices({super.endPoint = '/loggers'});

  @override
  Future<List<Logger>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('Logger Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<Logger>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Logger.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('LoggerServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Logger> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('Logger Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Logger>.fromJson(
        json.decode(response.body),
        (data) => Logger.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('LoggerServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Logger> create(Logger model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('Logger Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Logger>.fromJson(
        json.decode(response.body),
        (data) => Logger.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('LoggerServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Logger> update(int id, Logger model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('Logger Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Logger>.fromJson(
        json.decode(response.body),
        (data) => Logger.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('LoggerServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await client?.deleteById(super.endPoint, id: id);
      
      if (kDebugMode) {
        print('Logger Service Delete Response Body : ${response.body}');
      }
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) print('LoggerServices Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      
      if (kDebugMode) print('LoggerServices Storage initialized');
      
      final token = await super.storage?.read(BearerTokenKey);
      
      super.client = stockTrackerApiClient(token);
      
      if (kDebugMode) print('LoggerServices Client initialized');
      
    } catch (e) {
      if (kDebugMode) print('LoggerServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      
      if (kDebugMode) print('LoggerServices Client disposed');
      
      super.storage = null;
      
      if (kDebugMode) print('LoggerServices Storage disposed');
      
    } catch (e) {
      if (kDebugMode) print('LoggerServices Dispose Error: $e');
      rethrow;
    }
  }
}