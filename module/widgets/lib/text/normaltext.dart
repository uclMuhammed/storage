import 'package:flutter/material.dart';

class Normaltext extends StatefulWidget {
  final String text;
  const Normaltext({super.key, required this.text});

  @override
  State<Normaltext> createState() => _NormaltextState();
}

class _NormaltextState extends State<Normaltext> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(fontSize: 16),
    );
  }
}
