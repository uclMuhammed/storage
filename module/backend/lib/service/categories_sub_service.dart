import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/base/api_service.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CategoriesSubService extends BaseApiService<CategoriesSub> {
  CategoriesSubService({super.endPoint = '/categoriesSub'});

  int? _currentCategoryId;

  void setCategoryId(int categoryId) {
    _currentCategoryId = categoryId;
  }

  String get _endpoint {
    if (_currentCategoryId == null) {
      throw Exception('Category ID must be set before making any requests');
    }
    return '${super.endPoint}/$_currentCategoryId';
  }

  String _getFullEndpoint(int id) {
    return '$_endpoint/$id';
  }

  @override
  Future<List<CategoriesSub>> getAll() async {
    try {
      final response = await super.client?.getAll(_endpoint);
      if (kDebugMode) {
        print('CategoriesSub Service GetAll Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<List<CategoriesSub>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => CategoriesSub.fromJson(e)).toList(),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CategoriesSubService GetAll Error: $e');
      rethrow;
    }
  }

  @override
  Future<CategoriesSub> getById(int id) async {
    try {
      final response = await super.client?.getById(_endpoint, id: id);
      if (kDebugMode) {
        print('CategoriesSub Service GetById Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<CategoriesSub>.fromJson(
        json.decode(response.body),
        (data) => CategoriesSub.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CategoriesSubService GetById Error: $e');
      rethrow;
    }
  }

  @override
  Future<CategoriesSub> create(CategoriesSub model) async {
    try {
      final response = await super.client?.post(
            _endpoint,
            body: model.toJson(),
          );
      if (kDebugMode) {
        print('CategoriesSub Service Create Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<CategoriesSub>.fromJson(
        json.decode(response.body),
        (data) => CategoriesSub.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CategoriesSubService Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<CategoriesSub> update(int id, CategoriesSub model) async {
    try {
      final endpoint = _getFullEndpoint(id);
      final response = await super.client?.put(
            endpoint,
            body: model.toJson(),
          );
      if (kDebugMode) {
        print('CategoriesSub Service Update Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<CategoriesSub>.fromJson(
        json.decode(response.body),
        (data) => CategoriesSub.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CategoriesSubService Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final endPoint = _getFullEndpoint(id);
      final response = await super.client?.delete(
            endPoint,
          );
      if (kDebugMode) {
        print('CategoriesSub Service Delete Response Body : ${response.body}');
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
      if (kDebugMode) print('CategoriesSubService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      if (kDebugMode) print('CategoriesSubService Client disposed');
      super.storage = null;
      if (kDebugMode) print('CategoriesSubService Storage disposed');
    } catch (e) {
      if (kDebugMode) print('CategoriesSubService Dispose Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      if (kDebugMode) print('CategoriesSubService Storage initialized');
      final token = await super.storage?.read(BearerTokenKey);
      super.client = stockTrackerApiClient(token);
      if (kDebugMode) print('CategoriesSubService Client initialized');
    } catch (e) {
      if (kDebugMode) print('CategoriesSubService Init Error: $e');
      rethrow;
    }
  }
}
