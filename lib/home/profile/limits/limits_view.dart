import 'package:flutter/material.dart';

class LimitsView extends StatefulWidget {
  const LimitsView({super.key});

  @override
  State<LimitsView> createState() => _LimitsViewState();
}

class _LimitsViewState extends State<LimitsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Limits View')),
    );
  }
}
