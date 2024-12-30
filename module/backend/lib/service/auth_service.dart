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

    // Sadece ana response'a bakıyoruz
    if (response.statusCode == 200 && responseData['status'] == true) {
      final data = responseData['data'];
      if (data != null && data['token'] != null) {
        final token = data['token'] as String;
        if (token.isNotEmpty) {
          final tokenSaved = await super.storage?.write(BearerTokenKey, token);
          if (kDebugMode) {
            print('Token saved status: $tokenSaved');
            print('Token value: $token');
          }
          return tokenSaved ?? false;
        }
      }
    }

    // Genel hata durumu
    final message = responseData['message'] ?? 'Giriş başarısız';
    throw Exception(message);
    
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

    // Sadece başarılı kayıt durumunu kontrol et
    if (response.statusCode == 200 && responseData['status'] == true) {
      if (kDebugMode) {
        print('Register success');
      }
      return true;
    }

    // Hata durumu
    final message = responseData['message'] ?? 'Kayıt işlemi başarısız';
    throw Exception(message);
    
  } catch (e) {
    if (kDebugMode) {
      print('Register error: $e');
    }
    rethrow;
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
