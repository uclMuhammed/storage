import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../base/api_service.dart';
import '../const/keys.dart';
import '../implement/http_client.dart';
import '../models/authorities.dart';
import '../models/response/api_response.dart';
import '../storage/shared_preferences.dart';

class AuthoritiesService extends BaseApiService<Authorities> {
  AuthoritiesService({super.endPoint = '/authorities'});

  @override
  Future<List<Authorities>> getAll() async {
    try {
      //
      final response = await super.client?.getAll(super.endPoint);
      //
      if (kDebugMode) {
        print('Authorities Service GetAll Response Body : ${response.body}');
      }
      //
      final apiResponse = ApiResponse<List<Authorities>>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Authorities.fromJson(e)).toList(),
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('AuthoritiesService Get All Error: $e');
      rethrow;
    }
  }

  @override
  Future<Authorities> getById(int id) async {
    try {
      //
      final response = await super.client?.getById(super.endPoint, id: id);
      //
      if (kDebugMode) {
        print('Authorities Service GetById Response Body : ${response.body}');
      }
      //
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == true && responseData['data'] != null) {
        if (responseData['data'] is Map<String, dynamic>) {
          return Authorities.fromJson(responseData['data']);
        } else if (responseData['data'] is List &&
            responseData['data'].isNotEmpty) {
          return Authorities.fromJson(responseData['data'][0]);
        }
      }

      throw Exception('Data not found or invalid format');
    } catch (e) {
      if (kDebugMode) print('AuthoritiesService Get By Id Error: $e');
      rethrow;
    }
  }

  @override
  Future<Authorities> create(Authorities model) async {
    try {
      //
      final response = await super.client?.post(
            super.endPoint,
            body: model.toJson(),
          );
      //
      if (kDebugMode) {
        print('Authorities Service Create Response Body : ${response.body}');
      }
      //
      final apiResponse = ApiResponse<Authorities>.fromJson(
        json.decode(response.body),
        (data) => Authorities.fromJson(data as Map<String, dynamic>),
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<Authorities> update(int id, model) async {
    try {
      //
      final response = await super.client?.putById(
            super.endPoint,
            id: id,
            body: model.toJson(),
          );
      //
      if (kDebugMode) print(response.body);
      //
      final apiResponse = ApiResponse<Authorities>.fromJson(
        json.decode(response.body),
        (data) => (data as List).map((e) => Authorities.fromJson(e)).first,
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('AuthoritiesService Update Error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      //
      final response = await super.client?.deleteById(super.endPoint, id: id);
      //
      if (kDebugMode) print(response.body);
      //
      final apiResponse = ApiResponse<bool>.fromJson(
        json.decode(response.body),
        (data) => data,
      );
      //
      return apiResponse.data;
      //
    } catch (e) {
      if (kDebugMode) print('AuthoritiesService Delete Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> init() async {
    try {
      super.storage = await SharedPreferencesService.getInstance();
      //
      if (kDebugMode) print('AuthoritiesService Storage initialized');
      //
      final token = await super.storage?.read(BearerTokenKey);
      //
      super.client = stockTrackerApiClient(token);
      //
      if (kDebugMode) print('AuthoritiesService Client initialized');
      //
    } catch (e) {
      if (kDebugMode) print('AuthoritiesService Init Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    try {
      super.client = null;
      //
      if (kDebugMode) print('AuthoritiesService Client disposed');
      //
      super.storage = null;
      //
      if (kDebugMode) print('AuthoritiesService Storage disposed');
      //
    } catch (e) {
      if (kDebugMode) print('AuthoritiesService Dispose Error: $e');
      rethrow;
    }
  }
}
