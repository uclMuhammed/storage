import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() {
    return _instance;
  }

  AuthManager._internal() {
    // Singleton constructor
  }

  final AuthenticationService _authService = AuthenticationService();
  final AuthoritiesService _authoritiesService = AuthoritiesService();

  bool _isLoading = false;
  String? _error;
  bool _isLoggedIn = false;
  Authorities? _userAuthority;
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _isLoggedIn;
  Authorities? get userAuthority => _userAuthority;

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  Future<bool> login({
    required int companyCode,
    required String email,
    required String password,
  }) async {
    if (_isDisposed) return false;

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
        _error = 'Login failed';
        return false;
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Login Error: $e');
      return false;
    } finally {
      if (!_isDisposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> _loadAuthorities() async {
    if (_isDisposed) return;

    try {
      await _authoritiesService.init();
      final authorities = await _authoritiesService.getAll();

      if (!_isDisposed && authorities.isNotEmpty) {
        _userAuthority = authorities.first;
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Load Authorities Error: $e');
    }
  }

  Future<void> logout() async {
    if (_isDisposed) return;

    try {
      _isLoading = true;
      notifyListeners();

      await _authService.logout();

      _isLoggedIn = false;
      _userAuthority = null;
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Logout Error: $e');
    } finally {
      if (!_isDisposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _authService.dispose();
    _authoritiesService.dispose();
    super.dispose();
  }

  void reset() {
    _isDisposed = false;
    _isLoading = false;
    _error = null;
    _isLoggedIn = false;
    _userAuthority = null;
  }
}
