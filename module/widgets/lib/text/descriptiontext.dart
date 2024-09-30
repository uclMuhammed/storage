import 'package:flutter/material.dart';

class Descriptiontext extends StatefulWidget {
  final String? text;
  const Descriptiontext({super.key, this.text});

  @override
  State<Descriptiontext> createState() => _DescriptiontextState();
}

class _DescriptiontextState extends State<Descriptiontext> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text ?? "",
      style: const TextStyle(fontSize: 14),
    );
  }
}
