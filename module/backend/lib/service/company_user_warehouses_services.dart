import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CompanyUserWarehousesServices extends BaseApiService<CompanyUserWarehouses> with BaseServiceMixin {
  CompanyUserWarehousesServices({super.endPoint = '/companyUserWarehouses'});

  @override
  Future<List<CompanyUserWarehouses>> getAll() async {
    try {
      final response = await client?.getAll(endPoint);
      
      if (kDebugMode) {
        print('CompanyUserWarehouses Service GetAll Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<List<CompanyUserWarehouses>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => CompanyUserWarehouses.fromJson(e)).toList(),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesServices Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserWarehouses> getById(int id) async {
    try {
      final response = await client?.getById(endPoint, id: id);
      
      if (kDebugMode) {
        print('CompanyUserWarehouses Service GetById Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<CompanyUserWarehouses>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserWarehouses.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesServices GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserWarehouses> create(CompanyUserWarehouses model) async {
    try {
      final response = await client?.post(endPoint, body: model.toJson());
      
      if (kDebugMode) {
        print('CompanyUserWarehouses Service Create Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<CompanyUserWarehouses>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserWarehouses.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesServices Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserWarehouses> update(int id, CompanyUserWarehouses model) async {
    try {
      final response = await client?.putById(
        endPoint,
        id: id,
        body: model.toJson(),
      );
      
      if (kDebugMode) {
        print('CompanyUserWarehouses Service Update Response Body : ${response.body}');
      }
      
      final apiResponse = ApiResponse<CompanyUserWarehouses>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserWarehouses.fromJson(data as Map<String, dynamic>),
      );
      
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesServices Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Company User Warehouses Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      
      if (kDebugMode) print('CompanyUserWarehousesServices Storage initialized');
      
      final token = await super.storage?.read(BearerTokenKey);
      
      super.client = stockTrackerApiClient(token);
      
      if (kDebugMode) print('CompanyUserWarehousesServices Client initialized');
      
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesServices Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      
      if (kDebugMode) print('CompanyUserWarehousesServices Client disposed');
      
      super.storage = null;
      
      if (kDebugMode) print('CompanyUserWarehousesServices Storage disposed');
      
    } catch (e) {
      if (kDebugMode) print('CompanyUserWarehousesServices Dispose Error: $e');
      rethrow;
    }
  }
}