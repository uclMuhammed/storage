import 'package:backend/backend.dart';
import 'package:backend/const/keys.dart';
import 'package:flutter/foundation.dart';

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() {
    return _instance;
  }

  AuthManager._internal();

  final AuthenticationService _authService = AuthenticationService();
  final AuthoritiesService _authoritiesService = AuthoritiesService();

  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;
  Authorities? _userAuthority;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;
  Authorities? get userAuthority => _userAuthority;

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

      final loginSuccess = await _authService.login(
        companyCode: companyCode,
        email: email,
        password: password,
      );

      if (loginSuccess) {
        await _loadAuthorities();
        _isLoggedIn = true;
        return true;
      } else {
        _error = 'Giriş başarısız';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Login Error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadAuthorities() async {
    try {
      await _authoritiesService.init();
      final authorities = await _authoritiesService.getAll();

      if (authorities.isNotEmpty) {
        _userAuthority = authorities.first;
        if (kDebugMode) {
          print('Authority loaded: ${_userAuthority?.description}');
        }
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Load Authorities Error: $e');
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      final success = await _authService.logout();
      if (success) {
        _isLoggedIn = false;
        _userAuthority = null;
        if (kDebugMode) {
          print('Logout successful');
        }
      } else {
        _error = 'Çıkış yapılamadı';
        if (kDebugMode) {
          print('Logout failed');
        }
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Logout Error: $e');
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
      if (kDebugMode) print('Register Error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Uygulama başlangıcında login durumunu kontrol et
  Future<void> checkLoginStatus() async {
    try {
      await _authService.init();
      // Token kontrolü ve geçerlilik kontrolü yapılabilir
      final hasToken = await _authService.storage?.containsKey(BearerTokenKey);
      _isLoggedIn = hasToken ?? false;

      if (_isLoggedIn) {
        await _loadAuthorities();
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Check Login Status Error: $e');
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _isLoggedIn = false;
    _userAuthority = null;
  }
}
