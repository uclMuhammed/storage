import 'dart:convert';

import 'package:backend/const/headers.dart';
import 'package:backend/const/urls.dart';
import 'package:flutter/foundation.dart';

import '../base/auth_service.dart';
import '../const/keys.dart';
import '../implement/http_client.dart';
import '../storage/shared_preferences.dart';

class AuthenticationService extends BaseAuthService {
  AuthenticationService({
    super.endPoint,
    super.client,
    super.storage,
  });

  @override
  Future<void> init() async {
    try {
      //
      super.client = HttpClientManager(
        StockTrackerAuthUrl,
        StockTrackerAuthHeader,
      );
      //
      super.storage = await SharedPreferencesService.getInstance();
      //
      if (kDebugMode) print('LoginService initialized successfully');
      //
    } catch (e) {
      if (kDebugMode) print('Init error: $e');
      //
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    super.client = null;
    super.storage = null;
  }

  @override
  Future<bool> login({
    required int companyCode,
    required String email,
    required String password,
  }) async {
    //
    try {
      if (kDebugMode) print('Login Service');
      //
      super.endPoint = '/login';
      //
      final Map<String, dynamic> loginBody = {
        'companyCode': companyCode,
        'email': email,
        'password': password,
      };
      //
      final response = await super.client?.post(
            super.endPoint ?? '--',
            body: loginBody,
          );
      //
      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
      //
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      //
      if (response.statusCode == 200) {
        // Chech status code
        if (responseData['status'] == 'Success') {
          // Get token from data object
          final token = responseData['data']['token'] as String;

          if (token.isNotEmpty) {
            //Save token to storage
            final result =
                await super.storage?.write<String>(BearerTokenKey, token);
            //
            if (kDebugMode) print('Token Saved: $result');
            //
            return result ?? false;
          }
        }
      }
      //
      throw Exception(responseData['message'] ?? 'Login Failed');
      //
    } catch (e) {
      if (kDebugMode) print('Login Error: $e');
      //
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
      if (kDebugMode) print('Register Service');
      //
      super.endPoint = '/register';
      //
      final Map<String, dynamic> registerBody = {
        'companyName': companyName,
        'email': email,
        'password': password,
      };
      //
      final response = await super.client?.post(
            super.endPoint ?? '',
            body: registerBody,
          );
      //
      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
      //
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      //
      if (response.statusCode == 200) {
        if (responseData['status'] == 'Success') {
          return true;
        }
      }
      //
      throw Exception(responseData['message'] ?? 'Registration Failed');
      //
    } catch (e) {
      if (kDebugMode) print('Register Error: $e');
      //
      rethrow;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final value = await super.storage?.containsKey(BearerTokenKey);
      //
      if (value == true) {
        final result = await super.storage?.delete(BearerTokenKey);
        //
        if (kDebugMode) {
          if (result == true) {
            print('Token Deleted');
          } else {
            print('Token Not Deleted');
          }
        }
        //
        return true;
        //
      } else {
        //
        return false;
        //
      }
    } catch (e) {
      if (kDebugMode) print('Register Error: $e');
      //
      rethrow;
    }
  }
}
