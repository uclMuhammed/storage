part of 'signup_view.dart';

mixin SignupViewModel {
  AuthManager _authManager = AuthManager();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? companyNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company Name giriniz';
    }
    return null;
  }

  String? emailValidator(String? value) {
    RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (value == null || value.isEmpty) {
      return 'E-Mail giriniz';
    } else if (!regex.hasMatch(value)) {
      return 'Geçersiz E-Mail';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password giriniz';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password giriniz';
    } else if (value != passwordController.text) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  void signup() {
    if (formKey.currentState!.validate()) {
      _authManager.register(
        companyName: companyNameController.text,
        email: emailController.text,
        password: confirmPasswordController.text,
      );
    } else {}
  }

  void dispose() {
    companyNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
