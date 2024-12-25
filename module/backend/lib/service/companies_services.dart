import 'dart:convert';

import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../base/api_service.dart';
import '../models/index.dart';

class CompaniesServices extends BaseApiService<Companies>
    with BaseServiceMixin {
  CompaniesServices({super.endPoint = '/companies'});
  @override
  Future<Companies> create(Companies model) async {
    try {
      //
      final response =
          await super.client?.post(super.endPoint, body: model.toJson());
      //
      if (kDebugMode) {
        print('Companies Service Create Response Body : ${response.body}');
      }
      //
      final apiResponse = ApiResponse<Companies>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Companies.fromJson(e)).first,
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('CompaniesService Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Companies Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompaniesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() {
    super.client = null;
    super.storage = null;
    if (kDebugMode) print('CompaniesService Client disposed');
    if (kDebugMode) print('CompaniesService Storage disposed');
    return Future.value();
  }

  @override
  Future<List<Companies>> getAll() async {
    try {
      final response = await super.client?.getAll(super.endPoint);
      if (kDebugMode) {
        print('Companies Service GetAll Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<List<Companies>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Companies.fromJson(e)).toList(),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompaniesService Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Companies> getById(int id) async {
    try {
      final response = await super.client?.getById(super.endPoint, id: id);
      if (kDebugMode) {
        print('Companies Service GetById Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<Companies>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Companies.fromJson(e)).first,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompaniesService Get By Id Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      //
      if (kDebugMode) print('CompaniesService Storage initialized');
      //
      final token = await super.storage?.read(BearerTokenKey);
      //
      super.client = stockTrackerApiClient(token);
      //
      if (kDebugMode) print('CompaniesService Client initialized');
    } catch (e) {
      if (kDebugMode) print('CompaniesService Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<Companies> update(int id, Companies model) async {
    try {
      final response = await super
          .client
          ?.putById(super.endPoint, id: id, body: model.toJson());
      if (kDebugMode) {
        print('Companies Service Update Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<Companies>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Companies.fromJson(e)).first,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CompaniesService Update Error: $e');
      rethrow;
    }
  }
}
