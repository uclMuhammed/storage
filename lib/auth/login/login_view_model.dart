part of 'login_view.dart';

mixin LoginViewModel {
  AuthManager authManager = AuthManager();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController companyCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? companyCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company Code giriniz';
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

  void login() async {
    if (formKey.currentState!.validate()) {
      await authManager.login(
        companyCode: int.parse(companyCodeController.text),
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  void dispose() {
    companyCodeController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
