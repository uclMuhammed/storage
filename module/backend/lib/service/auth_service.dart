import 'dart:convert';

import 'package:backend/const/headers.dart';
import 'package:backend/const/urls.dart';
import 'package:flutter/foundation.dart';

import '../base/auth_service.dart';
import '../const/keys.dart';
import '../implement/http_client.dart';
import '../storage/shared_preferences.dart';

class AuthenticationService extends BaseAuthService {
  AuthenticationService({super.endPoint, super.client, super.storage});

  @override
  Future<void> init() async {
    try {
      super.client =
          HttpClientManager(StockTrackerAuthUrl, StockTrackerAuthHeader);
      super.storage = await SharedPreferencesService.getInstance();
    } catch (e) {
      if (kDebugMode) print('Init error: $e');
      rethrow;
    }
  }

  @override
  Future<bool> login({
    required int companyCode,
    required String email,
    required String password,
  }) async {
    try {
      super.endPoint = '/login';

      final response = await super.client?.post(
        super.endPoint ?? '',
        body: {
          'COMPANYCODE': companyCode,
          'EMAIL': email,
          'PASSWORD': password,
        },
      );

      final responseData = jsonDecode(response.body);

      // Response'un yapısını kontrol ediyoruz
      if (response.statusCode == 200 && responseData['status'] == true) {
        final token = responseData['data']['token'] as String;
        if (token.isNotEmpty) {
          // Token'ı saklama
          final tokenSaved = await super.storage?.write(BearerTokenKey, token);
          if (kDebugMode) {
            print('Token saved status: $tokenSaved');
            print('Token value: $token');
          }
          return tokenSaved ?? false;
        }
      }

      if (kDebugMode) {
        print('Login failed. Response data: $responseData');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      rethrow;
    }
  }

  @override
  Future<bool> register({
    required String companyName,
    required String email,
    required String password,
  }) async {
    try {
      super.endPoint = '/register';

      final response = await super.client?.post(
        super.endPoint ?? '',
        body: {
          'COMPANYNAME': companyName,
          'EMAIL': email,
          'PASSWORD': password,
        },
      );

      final responseData = jsonDecode(response.body);
      return response.statusCode == 200 && responseData['status'] == 'Success';
    } catch (e) {
      if (kDebugMode) print('Register error: $e');
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      if (await super.storage?.containsKey(BearerTokenKey) ?? false) {
        return await super.storage?.delete(BearerTokenKey) ?? false;
      }
      return false;
    } catch (e) {
      if (kDebugMode) print('Logout error: $e');
      return false;
    }
  }

  @override
  Future<void> dispose() async {
    super.client = null;
    super.storage = null;
  }
}
