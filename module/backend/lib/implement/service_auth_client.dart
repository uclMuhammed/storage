import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as client;

import '../const/headers.dart';
import '../const/urls.dart';
import '../exception/service_auth_exception.dart';
import '../models/auth/login_post.dart';
import 'shared_preferences.dart';

class ServiceAuthClient {
  String? _baseUrl;
  Map<String, String>? _header;
  final _preferencesManager = SharedPreferencesManager();
  final _rateLimiter = <String, DateTime>{};
  static const _minRequestInterval = Duration(milliseconds: 500);

  Future<void> init() async {
    _baseUrl = StockTrackerAuthUrl;
    _header = StockTrackerAuthHeader;
  }

  // Login işlemi
  Future<Map<String, dynamic>> login(
      int companyName, String email, String password) async {
    return await _withConnectivityCheck(() => _withRetry(() async {
          await _checkRateLimit('login');
          _checkInit('login');

          final Uri url = Uri.parse('$_baseUrl/login');
          final LoginPostModel loginBody = LoginPostModel(
            companyName: companyName,
            email: email,
            password: password,
          );

          try {
            final response = await _handleAuthError(() => client.post(
                  url,
                  headers: _header,
                  body: json.encode(loginBody.toJson()),
                ));

            if (kDebugMode) {
              print('Login Response: ${response.body}');
              print('Status Code: ${response.statusCode}');
            }

            final data = json.decode(response.body);

            if (response.statusCode == 200 && data['status'] == true) {
              if (data['data']?['token'] != null) {
                await saveAuthToken(data['data']['token']);
              }
              return {
                'success': true,
                'message': data['message'],
                'data': data
              };
            } else {
              return {
                'success': false,
                'message': data['message'] ?? 'Giriş başarısız',
                'data': data
              };
            }
          } catch (e) {
            throw AuthException(
              message: 'Login işlemi sırasında hata: $e',
              statusCode: 500,
              stackTrace: StackTrace.current,
              operation: 'login',
            );
          }
        }));
  }

  // Signup işlemi
  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String name,
    required int companyName,
  }) async {
    return await _withConnectivityCheck(() => _withRetry(() async {
          await _checkRateLimit('signup');
          _checkInit('signup');

          final Uri url = Uri.parse('$_baseUrl/register');
          final signupBody = {
            'email': email,
            'password': password,
            'name': name,
            'companyName': companyName,
          };

          try {
            final response = await client.post(
              url,
              headers: _header,
              body: json.encode(signupBody),
            );

            if (kDebugMode) {
              print('Signup Response: ${response.body}');
              print('Status Code: ${response.statusCode}');
            }

            final data = json.decode(response.body);

            if (response.statusCode == 201 && data['status'] == 'success') {
              return {
                'success': true,
                'message': 'Kayıt başarılı',
                'data': data
              };
            } else {
              return {
                'success': false,
                'message': data['message'] ?? 'Kayıt başarısız',
                'data': data
              };
            }
          } catch (e) {
            throw AuthException(
              message: 'Signup işlemi sırasında hata: $e',
              statusCode: 500,
              stackTrace: StackTrace.current,
              operation: 'signup',
            );
          }
        }));
  }

  // Logout işlemi
  Future<void> logout() async {
    try {
      // Token'ı temizle
      await clearAuthToken();
      print('Logout işlemi başarılı');
    } catch (e) {
      print('Logout işlemi başarısız: $e');
    }
  }

  // Yardımcı metodlar
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

  Future<void> saveAuthToken(String token) async {
    await _preferencesManager.setToken(token);
  }

  Future<String?> getAuthToken() async {
    return await _preferencesManager.getToken();
  }

  Future<void> clearAuthToken() async {
    await _preferencesManager.removeToken();
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getAuthToken();
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
    }
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<bool> isAuthenticated() async {
    try {
      final token = await getAuthToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      print('Token kontrol hatası: $e');
      return false;
    }
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _preferencesManager.getRefreshToken();
      if (refreshToken == null) return false;

      final Uri url = Uri.parse('$_baseUrl/refresh-token');
      final response = await client.post(
        url,
        headers: {'Authorization': 'Bearer $refreshToken'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _preferencesManager.setToken(data['token']);
        await _preferencesManager.setRefreshToken(data['refreshToken']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Token interceptor - 401 durumunda otomatik refresh
  Future<Response> _interceptRequest(
      Future<Response> Function() request) async {
    try {
      final response = await request();
      if (response.statusCode == 401) {
        final isRefreshed = await refreshToken();
        if (isRefreshed) {
          return await request();
        }
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<T> _withRetry<T>(Future<T> Function() request,
      {int maxAttempts = 3}) async {
    int attempts = 0;
    while (attempts < maxAttempts) {
      try {
        return await request();
      } catch (e) {
        attempts++;
        if (attempts == maxAttempts) rethrow;
        await Future.delayed(Duration(milliseconds: 500 * attempts));
      }
    }
    throw Exception('Max retry attempts reached');
  }

  Future<void> _checkRateLimit(String endpoint) async {
    final lastRequest = _rateLimiter[endpoint];
    if (lastRequest != null) {
      final difference = DateTime.now().difference(lastRequest);
      if (difference < _minRequestInterval) {
        await Future.delayed(_minRequestInterval - difference);
      }
    }
    _rateLimiter[endpoint] = DateTime.now();
  }

  Future<bool> checkConnectivity() async {
    try {
      final result = await client.get(Uri.parse('https://google.com'));
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<T> _withConnectivityCheck<T>(Future<T> Function() request) async {
    if (!await checkConnectivity()) {
      throw AuthException(
        message: 'İnternet bağlantısı yok',
        statusCode: 0,
        stackTrace: StackTrace.current,
        operation: 'connectivity',
      );
    }
    return await request();
  }

  Future<T> _handleAuthError<T>(Future<T> Function() request) async {
    try {
      final result = await request();
      return result;
    } catch (e) {
      if (e is AuthException && e.statusCode == 401) {
        await clearAuthToken(); // Token geçersiz ise temizle
        rethrow; // Hatayı yukarı fırlat
      }
      rethrow;
    }
  }
}
