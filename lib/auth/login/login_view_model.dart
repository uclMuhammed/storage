part of 'login_view.dart';

mixin LoginViewModel<T extends LoginView> on State<T> {
  bool _obscurePassword = true;
  AuthManager authManager = AuthManager();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController companyCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String? companyCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company Code giriniz';
    } else if (value.length != 5) {
      return 'Company Code 5 haneli olmalıdır';
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
    } else if (value.length < 8) {
      return 'Password en az 8 karakter olmalıdır';
    }
    return null;
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        context.showLoading();

        final loginSuccess = await authManager.login(
          companyCode: int.parse(companyCodeController.text),
          email: emailController.text,
          password: passwordController.text,
        );

        if (context.mounted) {
          context.hideLoading();

          if (loginSuccess) {
            // Form temizleme
            companyCodeController.clear();
            emailController.clear();
            passwordController.clear();
            formKey.currentState!.reset();

            // Başarılı bildirim
            context.showNotification(
              message: 'Giriş başarılı!',
              type: NotificationType.success,
            );

            await Future.delayed(const Duration(milliseconds: 500));

            if (context.mounted) {
              NavigationService.navigatorKey.currentState
                  ?.pushNamedAndRemoveUntil(
                AppRoutes.home,
                (route) => false,
              );
            }
          }
        }
      } catch (e) {
        if (context.mounted) {
          context.hideLoading();
          context.showNotification(
            message: e.toString(),
            type: NotificationType.error,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    companyCodeController.clear();
    emailController.clear();
    passwordController.clear();
    companyCodeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
