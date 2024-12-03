import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import 'package:widgets/buttons/custombutton.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text/titletext.dart';
import 'package:widgets/text_form_field/text_form_field.dart';

part 'signup_mixin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> with SignUpMixin {
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
                      const Titletext(text: "KAYIT OL"),
                      const SizedBox(height: 32),

                      // Şirket Adı
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        controller: _companyNameController,
                        text: "Şirket Adı",
                        validator: validateCompanyName,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        controller: _emailController,
                        text: "E-mail",
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 16),

                      // Şifre
                      CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscurePassword,
                        controller: _passwordController,
                        text: "Şifre",
                        suffixIcon: IconButton(
                          onPressed: togglePasswordVisibility,
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        ),
                        validator: validatePassword,
                      ),
                      const SizedBox(height: 16),

                      // Şifre Tekrar
                      CustomTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureConfirmPassword,
                        controller: _confirmPasswordController,
                        text: "Şifreyi Doğrula",
                        suffixIcon: IconButton(
                          onPressed: toggleConfirmPasswordVisibility,
                          icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                        ),
                        validator: validateConfirmPassword,
                      ),
                      const SizedBox(height: 32),

                      // Kayıt Ol Butonu
                      CustomButton(
                        onTap: _handleSignUp,
                        height: size.maxHeight * 0.08,
                        text: "Kayıt Ol",
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
