import 'dart:convert';
import 'package:backend/const/headers.dart';
import 'package:backend/const/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/implement/http_client.dart';
import 'package:backend/storage/shared_preferences.dart';

class AuthenticationService {
  late final HttpClientManager _client;
  late final SharedPreferencesService _storage;

  Future<void> init() async {
    try {
      _client = HttpClientManager(
        StockTrackerAuthUrl,
        StockTrackerAuthHeader,
      );

      _storage = await SharedPreferencesService.getInstance();

      if (kDebugMode) {
        print('AuthenticationService initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        print('AuthenticationService init error: $e');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login({
    required int companyCode,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        '/login',
        body: {
          'companyCode': companyCode,
          'email': email,
          'password': password,
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'Success') {
        final token = responseData['data']['token'] as String;

        if (token.isNotEmpty) {
          await _storage.write(BearerTokenKey, token);
          if (kDebugMode) {
            print('Token saved successfully');
          }
        }

        return {'success': true, 'user': responseData['data']['user'], 'message': 'Giriş başarılı'};
      }

      return {'success': false, 'message': responseData['message'] ?? 'Giriş başarısız'};
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return {'success': false, 'message': 'Bir hata oluştu: $e'};
    }
  }

  Future<Map<String, dynamic>> register({
    required String companyName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        '/register',
        body: {
          'companyName': companyName,
          'email': email,
          'password': password,
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'Success') {
        return {'success': true, 'message': 'Kayıt başarılı'};
      }

      return {'success': false, 'message': responseData['message'] ?? 'Kayıt başarısız'};
    } catch (e) {
      if (kDebugMode) {
        print('Register error: $e');
      }
      return {'success': false, 'message': 'Bir hata oluştu: $e'};
    }
  }

  Future<bool> logout() async {
    try {
      final hasToken = await _storage.containsKey(BearerTokenKey);
      if (hasToken) {
        final deleted = await _storage.delete(BearerTokenKey);
        if (kDebugMode) {
          print(deleted ? 'Token deleted' : 'Token deletion failed');
        }
        return deleted;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      return await _storage.containsKey(BearerTokenKey);
    } catch (e) {
      if (kDebugMode) {
        print('Check login status error: $e');
      }
      return false;
    }
  }

  void dispose() {
    // Gerekli temizlik işlemleri
  }
}
