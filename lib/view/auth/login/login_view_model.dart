import 'dart:async';

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isVisible = ValueNotifier(true);
  ServiceAuthClient serviceAuthClient = ServiceAuthClient();

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

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      init();
      await serviceAuthClient.login(
        int.parse(companyCodeController.text),
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  void init() {
    serviceAuthClient.init();
  }
}
