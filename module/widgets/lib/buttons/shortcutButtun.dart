import 'package:flutter/material.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text/index.dart';

class ShortcutButtun extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onPressed;
  const ShortcutButtun(
      {super.key, required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    ).paddingAll(16);
  }
}
