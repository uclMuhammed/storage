part of 'login_page.dart';

mixin LoginMixin on State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
