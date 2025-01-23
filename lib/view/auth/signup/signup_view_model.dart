import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class SignupViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  ServiceAuthClient serviceAuthClient = ServiceAuthClient();
  ValueNotifier<bool> isVisible = ValueNotifier<bool>(false);
  ValueNotifier<bool> isVisibleConfirm = ValueNotifier<bool>(false);

  String? companyNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter company name';
    } else if (value.length < 3) {
      return 'Company name must be at least 3 characters';
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

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (value != passController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      init();
      await serviceAuthClient.signup(
        companyNameController.text,
        emailController.text,
        passController.text,
      );
    }
  }

  @override
  void init() {
    serviceAuthClient.init();
  }
}
