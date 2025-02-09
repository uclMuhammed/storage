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
  final bool _isLoading = false;

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
    try {
      if (formKey.currentState?.validate() == true) {
        final success = await _authClient.login(
          int.parse(companyCodeController.text),
          emailController.text,
          passwordController.text,
        );

        if (success == true) {
          routeController.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            Routes.home.routeName,
            (route) => false,
          );
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
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
