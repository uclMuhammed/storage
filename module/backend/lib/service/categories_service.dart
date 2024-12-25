import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CategoriesService extends BaseApiService<Categories> {
  CategoriesService({super.endPoint = '/categories'});

  @override
  Future<Categories> create(Categories model) async {
    try {
      //
      final response = await super.client?.post(
            super.endPoint,
            body: model.toJson(),
          );
      //
      if (kDebugMode) {
        print('Categories Service Create Response Body : ${response.body}');
      }
      //
      final apiResponse = ApiResponse<Categories>.fromJson(
        json.decode(response.body),
        (data) => Categories.fromJson(data as Map<String, dynamic>),
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('CategoriesService Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final response = await super.client?.deleteById(super.endPoint, id: id);
      if (kDebugMode) {
        print('Categories Service Delete Response Body : ${response.body}');
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
      final errorMessage = e
          .toString()
          .replaceAll('Exception:', '')
          .replaceAll('Error:', '')
          .trim();
      throw Exception('Kategori silinemedi: $errorMessage');
    }
  }

  @override
  Future<void> dispose() {
    super.client = null;
    super.storage = null;
    if (kDebugMode) print('CategoriesService Client disposed');
    if (kDebugMode) print('CategoriesService Storage disposed');
    return Future.value();
  }

  @override
  Future<List<Categories>> getAll() async {
    final response = await super.client?.getAll(super.endPoint);
    if (kDebugMode) {
      print('Categories Service GetAll Response Body : ${response.body}');
    }
    final apiResponse = ApiResponse<List<Categories>>.fromJson(
      json.decode(response.body),
      (data) => (data as List).map((e) => Categories.fromJson(e)).toList(),
    );
    return apiResponse.data;
  }

  @override
  Future<Categories> getById(int id) async {
    try {
      final response = await super.client?.getById(super.endPoint, id: id);

      if (kDebugMode) {
        print('Categories Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Categories>.fromJson(
        json.decode(response.body),
        (data) => Categories.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CategoriesService GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      if (kDebugMode) print('CategoriesService Storage initialized');
      final token = await super.storage?.read(BearerTokenKey);
      super.client = stockTrackerApiClient(token);
      if (kDebugMode) print('CategoriesService Client initialized');
    } catch (e) {
      if (kDebugMode) print('CategoriesService Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<Categories> update(int id, Categories model) async {
    try {
      final response = await super
          .client
          ?.putById(super.endPoint, id: id, body: model.toJson());
      if (kDebugMode) {
        print('Categories Service Update Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<Categories>.fromJson(
        json.decode(response.body),
        (data) => Categories.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CategoriesService Update Error: $e');
      rethrow;
    }
  }
}
