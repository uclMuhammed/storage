import 'package:flutter/material.dart';

class Titletext extends StatelessWidget {
  final String text;
  const Titletext({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 26));
  }
}
