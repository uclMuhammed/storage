import 'package:flutter/material.dart';
import 'package:storage/pages/storage_list_page/storage_page.dart';
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
                    obscureText: false,
                    controller: _companynameController,
                    text: "Şirket Adı",
                    validator: _validateCompanyName,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    obscureText: false,
                    controller: _emailController,
                    text: "E-mail",
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    obscureText: _obscureText,
                    controller: _passwordController,
                    suffixIcon: IconButton(
                        onPressed: togglePasswordVisibility,
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    text: "Şifre",
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onTap: _submit,
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
  }
}
