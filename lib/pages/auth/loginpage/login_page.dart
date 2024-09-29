import 'package:flutter/material.dart';
import 'package:storage/pages/storage_list_page/storage_page.dart';
part 'login_mixin.dart';

class LoginScreen extends StatefulWidget {
  final bool Function(String, String) authenticateUser;

  const LoginScreen({super.key, required this.authenticateUser});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Giriş Yap',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen kullanıcı adınızı girin';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen şifrenizi girin';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
