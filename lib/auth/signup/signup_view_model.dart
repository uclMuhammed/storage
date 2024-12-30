part of 'signup_view.dart';

mixin SignupViewModel<T extends StatefulWidget> on State<T> {
  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  AuthManager _authManager = AuthManager();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String? companyNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company Name giriniz';
    } else if (value.length < 3) {
      return 'Company Name en az 3 karakter olmalıdır';
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
    } else if (value.length < 8) {
      return 'Şifre en az 8 karakter olmalıdır';
    }
    return null;
  }

  void signup(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        // Yükleme göster
        context.showLoading();

        // Register işlemini dene
        final success = await _authManager.register(
          companyName: companyNameController.text,
          email: emailController.text,
          password: confirmPasswordController.text,
        );

        // Yüklemeyi kapat
        context.hideLoading();

        if (success) {
          // Form alanlarını temizle
          companyNameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          formKey.currentState!.reset();

          // Başarılı mesajı göster
          context.showNotification(
            message: 'Kayıt başarılı! Lütfen giriş yapınız.',
            type: NotificationType.success,
          );

          // Login sayfasına yönlendir
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      } catch (e) {
        // Yüklemeyi kapat
        context.hideLoading();

        // Hata mesajını göster
        context.showNotification(
          message: e.toString(),
          type: NotificationType.error,
        );
      }
    }
  }

  @override
  void dispose() {
    companyNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
