import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CountriesServices extends BaseApiService<Countries> with BaseServiceMixin {
  CountriesServices({super.endPoint = '/countries'});

  @override
  Future<List<Countries>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('Countries Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<Countries>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Countries.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CountriesServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Countries> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('Countries Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Countries>.fromJson(
        json.decode(response.body),
        (data) => Countries.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CountriesServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<Countries> create(Countries model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('Countries Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Countries>.fromJson(
        json.decode(response.body),
        (data) => Countries.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CountriesServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Countries> update(int id, Countries model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('Countries Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<Countries>.fromJson(
        json.decode(response.body),
        (data) => Countries.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CountriesServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Countries Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CountriesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      
      if (kDebugMode) print('CountriesServices Storage initialized');
      
      final token = await super.storage?.read(BearerTokenKey);
      
      super.client = stockTrackerApiClient(token);
      
      if (kDebugMode) print('CountriesServices Client initialized');
      
    } catch (e) {
      if (kDebugMode) print('CountriesServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      
      if (kDebugMode) print('CountriesServices Client disposed');
      
      super.storage = null;
      
      if (kDebugMode) print('CountriesServices Storage disposed');
      
    } catch (e) {
      if (kDebugMode) print('CountriesServices Dispose Error: $e');
      rethrow;
    }
  }
}