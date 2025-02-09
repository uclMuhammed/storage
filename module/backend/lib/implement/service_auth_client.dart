import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as client;
import '../models/auth/signup_post.dart';
import '../interface/i_service_auth_client.dart';

class ServiceAuthClient implements IServiceAuthClient {
  String? _baseUrl;

  Map<String, String>? _header;

  final _storage = SharedPreferencesManager();

  ServiceAuthClient();

  Future<void> init() async {
    _baseUrl = StockTrackerAuthUrl;
    _header = StockTrackerAuthHeader;
  }

  // Login işlemi ve token kaydetme
  @override
  Future<bool> login(int companyCode, String email, String password) async {
    try {
      _checkInit('login');

      final Uri url = Uri.parse('$apiBaseUrl/auth/login');

      final LoginPostModel loginBody = LoginPostModel(
        companyCode: companyCode,
        email: email,
        password: password,
      );

      final response = await client.post(
        url,
        headers: _header,
        body: json.encode(
          loginBody.toJson(),
        ),
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        print('Response headers: ${response.headers}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data']['token'] != null) {
          await _storage.setToken(data['data']['token']);
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Login error details: $e');
      }
      return false;
    }
  }

  // Token kontrolü
  @override
  Future<bool> isAuthenticated() async {
    try {
      final token = await _storage.getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Logout ve token silme
  @override
  Future<void> logout() async {
    try {
      await _storage.clearAllTokens();
    } catch (e) {
      rethrow;
    }
  }

  // Token alma
  @override
  Future<String?> getToken() async {
    return _storage.getToken();
  }

  // Authorization header'ı oluşturma
  @override
  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    if (token != null) {
      return {
        ..._header ?? {},
        'Authorization': 'Bearer $token',
      };
    }
    return _header ?? {};
  }

  // Init kontrolü
  void _checkInit(String operation) {
    if (_baseUrl == null || _header == null) {
      throw AuthExceptionOnInit(
        message: 'ServiceAuthClient not initialized',
        statusCode: 500,
        stackTrace: StackTrace.current,
        operation: operation,
        type: 'init',
        name: 'ServiceAuthClient',
      );
    }
  }

  @override
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
      final Uri url = Uri.parse('$_baseUrl/signup');
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
}
