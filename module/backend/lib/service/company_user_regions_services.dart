import 'dart:convert';

import 'package:backend/base/api_service.dart';
import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/models/index.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../exception/http_custom_exception.dart';

class CompanyUserRegionsServices extends BaseApiService<CompanyUserRegions>
    with BaseServiceMixin {
  CompanyUserRegionsServices({super.endPoint = '/companyUserRegion'});

  @override
  Future<CompanyUserRegions> create(CompanyUserRegions model) async {
    try {
      final response = await super.client?.post(
            super.endPoint,
            body: model.toJson(),
          );
      if (kDebugMode) {
        print(
            'Company User Regions Service Create Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<CompanyUserRegions>.fromJson(
        json.decode(response.body),
        (data) => CompanyUserRegions.fromJson(data),
      );
      return apiResponse.data;
    } catch (e) {
      if (e is HttpCustomException) {
        rethrow;
      } else {
        throw HttpCustomException(statusCode: 422, message: e.toString());
      }
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print(
            'Company User Regions Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRegionsService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      super.storage = null;
      if (kDebugMode) print('CompanyUserRegionsService Client disposed');
      if (kDebugMode) print('CompanyUserRegionsService Storage disposed');
      return Future.value();
    } catch (e) {
      if (kDebugMode) print('CompanyUserRegionsService Dispose Error: $e');
      rethrow;
    }
  }

  @override
  Future<List<CompanyUserRegions>> getAll() async {
    try {
      final response = await super.client?.getAll(super.endPoint);
      if (kDebugMode) {
        print(
            'CompanyUserRegions Service GetAll Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<List<CompanyUserRegions>>.fromJson(
        json.decode(response.body),
        (data) =>
            (data as List).map((e) => CompanyUserRegions.fromJson(e)).toList(),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRegionsService Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserRegions> getById(int id) async {
    try {
      final response = await super.client?.getById(super.endPoint, id: id);
      if (kDebugMode) {
        print(
            'CompanyUserRegions Service GetById Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<CompanyUserRegions>.fromJson(
        json.decode(response.body),
        (data) =>
            (data as List).map((e) => CompanyUserRegions.fromJson(e)).first,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRegionsService Get By Id Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      if (kDebugMode) print('CompanyUserRegionsService Storage initialized');
      final token = await super.storage?.read(BearerTokenKey);
      if (kDebugMode) print('CompanyUserRegionsService Storage initialized');
      super.client = stockTrackerApiClient(token);
      if (kDebugMode) print('CompanyUserRegionsService Client initialized');
    } catch (e) {
      if (kDebugMode) print('CompanyUserRegionsService Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<CompanyUserRegions> update(int id, CompanyUserRegions model) async {
    try {
      final response = await super
          .client
          ?.putById(super.endPoint, id: id, body: model.toJson());
      if (kDebugMode) {
        print(
            'CompanyUserRegions Service Update Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<CompanyUserRegions>.fromJson(
        json.decode(response.body),
        (data) =>
            (data as List).map((e) => CompanyUserRegions.fromJson(e)).first,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompanyUserRegionsService Update Error: $e');
      rethrow;
    }
  }
}
