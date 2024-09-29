import 'package:flutter/material.dart';
part 'signup_mixin.dart';

class SignUpScreen extends StatefulWidget {
  final Function(String, String) addUser;

  const SignUpScreen({super.key, required this.addUser});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignUpMixin {
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
              'Kayıt Ol',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
              validator: validateUsername, // mixin'deki doğrulama kullanılıyor
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: togglePasswordVisibility, // mixin fonksiyonu
                ),
              ),
              obscureText: _obscurePassword,
              validator: validatePassword, // mixin'deki doğrulama kullanılıyor
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Şifreyi Doğrula',
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed:
                      toggleConfirmPasswordVisibility, // mixin fonksiyonu
                ),
              ),
              obscureText: _obscureConfirmPassword,
              validator:
                  validateConfirmPassword, // mixin'deki doğrulama kullanılıyor
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
