import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Key? globalKey;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String text;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.validator,
      required this.text,
      this.suffixIcon,
      required this.obscureText,
      required this.keyboardType,
      this.globalKey});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: globalKey,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(text),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
