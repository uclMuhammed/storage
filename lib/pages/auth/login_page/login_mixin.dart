part of 'login_page.dart';

mixin LoginMixin on State<LoginScreen> {
  final AuthManager _auth = AuthManager();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _companyCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _companyCodeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _auth.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final success = await _auth.login(
      companyCode: 68738,
      email: "test11@gmail.com",
      password: "testpass",
    );

    if (success && mounted) {
      // Login başarılı - Ana sayfaya yönlendir
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            authManager: _auth,
          ),
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_auth.error ?? 'Login failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
      return 'Lütfen Şirket Kodunu girin';
    }
    return null;
  }
}
