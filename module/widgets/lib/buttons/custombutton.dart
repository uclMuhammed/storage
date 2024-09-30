import 'package:flutter/material.dart';
import 'package:widgets/text/normaltext.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final double height;
  final String text;
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.height,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        minimumSize: Size(double.infinity, height),
      ),
      child: Normaltext(
        text: text,
      ),
    );
  }
}
