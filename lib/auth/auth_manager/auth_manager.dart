
import 'package:backend/const/keys.dart';
import 'package:backend/service/index.dart';
import 'package:flutter/material.dart';
import 'package:backend/backend.dart';

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  final _authService = AuthenticationService();

  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;

Future<void> checkLoginStatus() async {
  try {
    await _authService.init();
    final token = await _authService.storage?.read<String>(BearerTokenKey);
    
    if (token != null) {
      // Token'ın geçerliliğini kontrol edebiliriz
      // Örneğin: token'ın süresi dolmuş mu?
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    
    notifyListeners();
  } catch (e) {
    _error = e.toString();
    _isLoggedIn = false;
    notifyListeners();
  }
}

Future<bool> login({
  required int companyCode,
  required String email,
  required String password,
}) async {
  try {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await _authService.init();
    _isLoggedIn = await _authService.login(
      companyCode: companyCode,
      email: email,
      password: password,
    );

    notifyListeners();
    return _isLoggedIn;

  } catch (e) {
    _error = e.toString();
    _isLoggedIn = false;
    notifyListeners();
    rethrow;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<bool> register({
    required String companyName,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.init();
      final success = await _authService.register(
        companyName: companyName,
        email: email,
        password: password,
      );

      if (!success) {
        _error = 'Kayıt başarısız';
      }

      return success;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      final success = await _authService.logout();
      if (success) {
        _isLoggedIn = false;
      } else {
        _error = 'Çıkış yapılamadı';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetState() {
    _isLoading = false;
    _error = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
