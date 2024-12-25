import 'dart:convert';

import 'package:backend/models/response/api_response.dart';
import 'package:flutter/foundation.dart';

mixin BaseServiceMixin {
  Future<T> handleApiCall<T>(
      Future<T> Function() apiCall, String operation) async {
    try {
      final result = await apiCall();
      if (kDebugMode) {
        print('$runtimeType $operation başarılı');
      }
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('$runtimeType $operation hatası: $e');
      }
      rethrow;
    }
  }

  Future<ApiResponse<T>> parseResponse<T>(
    String responseBody,
    T Function(dynamic) fromJson,
  ) async {
    try {
      final decoded = json.decode(responseBody);
      return ApiResponse<T>.fromJson(decoded, fromJson);
    } catch (e) {
      if (kDebugMode) {
        print('Response parse hatası: $e');
      }
      rethrow;
    }
  }
}
