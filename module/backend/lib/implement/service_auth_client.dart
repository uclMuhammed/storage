import 'dart:convert';

import 'package:backend/models/auth/signup_post.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as client;

import '../const/headers.dart';
import '../const/urls.dart';
import '../exception/service_auth_exception.dart';
import '../models/auth/login_post.dart';

class ServiceAuthClient {
  String? _baseUrl;
  Map<String, String>? _header;

  ServiceAuthClient();

  Future<void> init() async {
    _baseUrl = StockTrackerAuthUrl;
    _header = StockTrackerAuthHeader;
  }

  Future<bool> login(int companyName, String email, String password) async {
    try {
      if (_baseUrl == null || _header == null) {
        throw AuthExceptionOnInit(
          message: 'ServiceAuthClient not initialized',
          statusCode: 500,
          stackTrace: StackTrace.current,
          operation: 'login',
          type: 'init',
          name: 'ServiceAuthClient',
        );
      }
      // ---
      final Uri url = Uri.parse('$_baseUrl/login');
      // ---
      final LoginPostModel loginBody = LoginPostModel(
        companyName: companyName,
        email: email,
        password: password,
      );
      // ---
      final response = await client.post(
        url,
        headers: _header,
        body: json.encode(loginBody.toJson()),
      );
      //
      if (kDebugMode) {
        print('Response: ${response.body}');
        print('Status Code: ${response.statusCode}');
        print('Header: ${response.headers}');
      }
      //
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == 'success';
      }
      //
      return true;
      //
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signup(String companyName, String email, String password) async {
    try {
      if (_baseUrl == null || _header == null) {
        throw AuthExceptionOnInit(
          message: 'ServiceAuthClient not initialized',
          statusCode: 500,
          stackTrace: StackTrace.current,
          operation: 'signup',
          type: 'init',
          name: 'ServiceAuthClient',
        );
      }
      // ---
      final Uri url = Uri.parse('$_baseUrl/register');
      // ---
      final SignupPostModel signupBody = SignupPostModel(
        companyName: companyName,
        email: email,
        password: password,
      );
      // ---
      final response = await client.post(
        url,
        headers: _header,
        body: json.encode(signupBody.toJson()),
      );
      //
      if (kDebugMode) {
        print('Response: ${response.body}');
        print('Status Code: ${response.statusCode}');
        print('Header: ${response.headers}');
      }
      //
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == 'success';
      }
      //
      return true;
      //
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {} catch (e) {
      rethrow;
    }
  }
}
