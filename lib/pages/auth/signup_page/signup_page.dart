import 'package:flutter/material.dart';
import 'package:widgets/buttons/custombutton.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text/titletext.dart';
import 'package:widgets/text_form_field/text_form_field.dart';
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
    return LayoutBuilder(
      builder: (context, size) {
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
                  CustomTextFormField(
                    obscureText: false,
                    text: 'Şirket Adı',
                    controller: _emailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    obscureText: false,
                    text: 'E-mail',
                    controller: _emailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      text: 'Sifre',
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: togglePasswordVisibility,
                      ),
                      validator: validatePassword),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                      obscureText: _obscureConfirmPassword,
                      controller: _confirmPasswordController,
                      text: 'Sifreyi Doğrula',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: toggleConfirmPasswordVisibility,
                      ),
                      validator: validateConfirmPassword),
                  const SizedBox(height: 32),
                  CustomButton(
                      onTap: _submit,
                      height: size.maxHeight * 0.08,
                      text: "Kayıt Ol")
                ],
              ),
            ),
          ),
        ).centerX();
      },
    );
  }
}
