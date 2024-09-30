part of 'signup_page.dart';

mixin SignUpMixin on State<SignUpScreen> {
  //formkey

  final _formKey = GlobalKey<FormState>();
  // Şifre görünürlüğü yönetimi
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // TextEditingController yönetimi
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Şifre görünürlüğünü değiştiren fonksiyon
  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // Şifre doğrulama görünürlüğünü değiştiren fonksiyon
  void toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  // Kayıt işlemi
  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.addUser(
        _emailController.text,
        _passwordController.text,
      );
      showSnackBar(
          context, 'Kayıt Başarılı!'); // mixin'deki fonksiyon kullanıldı
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
  }

  // TextEditingController'ları temizlemek
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Ortak SnackBar gösterimi
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Ortak doğrulama fonksiyonu (Şifre kontrolü dahil)
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifrenizi girin';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }

  // Email doğrulama fonksiyonu
  String? _validateEmail(String? value) {
    // Eğer değer boşsa hata döndür
    if (value == null || value.isEmpty) {
      return 'Lütfen bir e-posta giriniz.';
    }
    // RegEx ile email formatı kontrolü
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz.';
    }
    return null; // Doğruysa null döner (hata yok)
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifrenizi tekrar girin';
    } else if (value != _passwordController.text) {
      return 'Şifreler uyuşmuyor';
    }
    return null;
  }
}
