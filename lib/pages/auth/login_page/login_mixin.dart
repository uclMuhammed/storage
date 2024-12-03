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
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final success = await _auth.login(
          companyCode: int.parse(_companyCodeController.text),
          email: _emailController.text,
          password: _passwordController.text,
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
          // Hata mesajını göster
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_auth.error ?? 'Giriş başarısız'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bir hata oluştu: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // Validation metodları
  String? validateCompanyCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şirket kodu gerekli';
    }
    if (int.tryParse(value) == null) {
      return 'Geçerli bir şirket kodu giriniz';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta gerekli';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre gerekli';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
