part of 'login_page.dart';

mixin LoginMixin on State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  final _usernameController = TextEditingController();
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

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen kullanıcı adınızı girin';
    }
    return null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      bool isAuthenticated = widget.authenticateUser(
        _usernameController.text,
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
      _usernameController.clear();
      _passwordController.clear();
    }
  }
}
