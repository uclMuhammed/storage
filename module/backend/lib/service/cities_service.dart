import 'dart:convert';

import 'package:backend/base/base_service_mixin.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/models/response/api_response.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../base/api_service.dart';
import '../models/cities.dart';

class CitiesService extends BaseApiService<Cities> with BaseServiceMixin {
  CitiesService({super.endPoint = '/cities'});

  int? _currentCountryId;

  void setCountryId(int countryId) {
    _currentCountryId = countryId;
  }

  String get _baseEndpoint => super.endPoint;

  String _getEndpoint([int? cityId]) {
    if (_currentCountryId == null) {
      throw Exception('Country ID must be set before making any requests');
    }

    if (cityId != null) {
      return '$_baseEndpoint/$_currentCountryId/$cityId';
    }
    return '$_baseEndpoint/$_currentCountryId';
  }

  @override
  Future<bool> delete(int id) async {
    try {
      final endPoint = _getEndpoint();
      final response = await super.client?.deleteById(endPoint, id: id);
      if (kDebugMode) {
        print('Cities Service Delete Response Body : ${response.body}');
      }
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CitiesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      client = null;
      if (kDebugMode) print('CitiesService Client disposed');
      storage = null;
      if (kDebugMode) print('CitiesService Storage disposed');
    } catch (e) {
      if (kDebugMode) print('CitiesService Dispose Error: $e');
      rethrow;
    }
  }

  @override
  Future<List<Cities>> getAll() async {
    try {
      final endpoint = _getEndpoint();
      final response = await client?.getAll(endpoint);
      //
      if (kDebugMode) {
        print('Cities Service GetAll Response Body : ${response.body}');
      }
      //
      final apiResponse = ApiResponse<List<Cities>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Cities.fromJson(e)).toList(),
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('CitiesService Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Cities> getById(int id) async {
    try {
      final response = await client?.getById(super.endPoint, id: id);

      if (kDebugMode) {
        print('Cities Service GetById Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Cities>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Cities.fromJson(e)).first,
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CitiesService Get By Id Error: $e');
      rethrow;
    }
  }

  @override
  Future<Cities> create(Cities model) async {
    try {
      final endpoint = _getEndpoint();
      final response = await client?.post(
        endpoint,
        body: model.toJson(),
      );

      if (kDebugMode) {
        print('Cities Service Create Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Cities>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Cities.fromJson(e)).first,
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CitiesService Create Error: $e');
      rethrow;
    }
  }

  @override
  Future<Cities> update(int id, Cities model) async {
    try {
      final endpoint = _getEndpoint();
      final response = await client?.putById(
        endpoint,
        body: model.toJson(),
        id: id,
      );

      if (kDebugMode) {
        print('Cities Service Update Response Body : ${response.body}');
      }

      final apiResponse = ApiResponse<Cities>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Cities.fromJson(e)).first,
      );

      return apiResponse.data;
    } catch (e) {
      if (kDebugMode) print('CitiesService Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      storage = await SharedPreferencesService.getInstance();
      if (kDebugMode) print('CitiesService Storage initialized');
      final token = await storage?.read(BearerTokenKey);
      client = stockTrackerApiClient(token);
      if (kDebugMode) print('CitiesService Client initialized');
    } catch (e) {
      if (kDebugMode) print('CitiesService Init Error: $e');
      rethrow;
    }
  }
}
