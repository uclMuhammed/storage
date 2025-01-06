part of 'login_view.dart';

mixin LoginViewModel on State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController companyCodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController twoFactorController = TextEditingController();

  bool _obscurePassword = true;
  bool isLoading = false;
  bool requires2FA = false;
  final AuthManager authManager = AuthManager();

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
      return 'Geçersiz E-Mail';
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

  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);

        final loginResponse = await authManager.login(
          companyCode: int.parse(companyCodeController.text),
          email: emailController.text,
          password: passwordController.text,
        );

        if (!mounted) return;

        if (loginResponse) {
          // Login başarılı, ana sayfaya yönlendir
          _clearForm();

          context.showNotification(
            message: 'Giriş başarılı!',
            type: NotificationType.success,
          );

          await Future.delayed(const Duration(milliseconds: 500));

          if (!mounted) return;
          NavigationService.navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppRoutes.home,
            (route) => false,
          );
        } else {
          // Login başarısız, 2FA gerekiyor
          setState(() {
            requires2FA = true;
            isLoading = false;
          });
        }
      } catch (e) {
        if (!mounted) return;

        // Hata mesajını göster
        context.showNotification(
          message: e
              .toString()
              .replaceAll('Exception: ', ''), // "Exception: " prefix'ini kaldır
          type: NotificationType.error,
        );

        // 3 kez hatalı giriş durumunda formu temizle
        if (e.toString().contains('3 kez hatalı giriş')) {
          _clearForm();
        }
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }

  void _clearForm() {
    companyCodeController.clear();
    emailController.clear();
    passwordController.clear();
    twoFactorController.clear();
    formKey.currentState?.reset();
  }

  @override
  void dispose() {
    companyCodeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    twoFactorController.dispose();
    super.dispose();
  }
}
