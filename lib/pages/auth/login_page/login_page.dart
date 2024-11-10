import 'package:backend/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import 'package:storage/pages/home/home_page.dart';
import 'package:widgets/buttons/custombutton.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text/titletext.dart';
import 'package:widgets/text_form_field/text_form_field.dart';
part 'login_mixin.dart';

class LoginScreen extends StatefulWidget {
  final bool Function(String, String) authenticateUser;

  const LoginScreen({super.key, required this.authenticateUser});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return AnimatedBuilder(
          animation: _auth,
          builder: (context, child) {
            if (_auth.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Titletext(text: "GİRİŞ YAP"),
                      const SizedBox(height: 32),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        controller: _companyCodeController,
                        text: "Şirket Kodu",
                        validator: _validateCompanyName,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        controller: _emailController,
                        text: "E-mail",
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        controller: _passwordController,
                        suffixIcon: IconButton(
                            onPressed: togglePasswordVisibility,
                            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility)),
                        text: "Şifre",
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        onTap: () async {
                          _handleLogin();
                        },
                        height: size.maxHeight * 0.08,
                        text: 'Giriş Yap',
                      ),
                    ],
                  ),
                ),
              ),
            ).centerX();
          },
        );
      },
    );
  }
}
