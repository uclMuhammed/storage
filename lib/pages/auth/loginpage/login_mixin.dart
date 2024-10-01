part of 'login_page.dart';

mixin LoginMixin on State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  final _companynameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifrenizi girin';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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

  String? _validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen Şirket adını girin';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      bool isAuthenticated = widget.authenticateUser(
        _emailController.text,
        _passwordController.text,
      );

      if (isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Giriş Başarılı!')),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StorageScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Geçersiz kullanıcı adı veya şifre')),
        );
      }
      _emailController.clear();
      _passwordController.clear();
    }
  }
}
