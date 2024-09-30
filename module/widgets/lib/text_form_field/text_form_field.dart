import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String text;
  final bool obscureText;
  final Widget? suffixIcon;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      required this.text,
      this.suffixIcon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(text),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
