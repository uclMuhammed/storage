import 'dart:async';
import 'package:backend/const/index.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';
import 'package:backend/implement/service_auth_client.dart';
import '../../../features/routes/routes.dart';

class LoginViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isVisible = ValueNotifier(true);

  final _authClient = ServiceAuthClient();
  String? _errorMessage;
  bool _isLoading = false;

  String? get errorMessage => _errorMessage;
  @override
  bool get isLoading => _isLoading;

  String? companyCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter company code';
    } else if (value.length != 5) {
      return 'Company code must be at least 5 characters';
    }
    return null;
  }

  String? emailValidator(String? value) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        _isLoading = true;
        notifyListeners();

        final result = await _authClient.login(
          int.parse(companyCodeController.text),
          emailController.text,
          passwordController.text,
        );

        print('Login sonucu: $result');

        if (result['success']) {
          print('Login başarılı');
          routeController.navigatorKey.currentState?.pushNamedAndRemoveUntil(
              Routes.home.routeName, (route) => false);
        } else {
          print('Login başarısız: ${result['message']}');
          _errorMessage = result['message'] ?? 'Giriş başarısız';
        }
      } catch (e) {
        print('Login hatası: $e');
        if (e.toString().contains('İnternet bağlantısı yok')) {
          _errorMessage = 'İnternet bağlantınızı kontrol edin';
        } else {
          _errorMessage = 'Bir hata oluştu: ${e.toString()}';
        }
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<bool> checkAuthStatus() async {
    try {
      return await _authClient.isAuthenticated();
    } catch (e) {
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void init() async {
    _authClient.init();
  }

  @override
  void dispose() {
    companyCodeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    isVisible.dispose();
    super.dispose();
  }
}
