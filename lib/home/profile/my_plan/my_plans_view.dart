import 'package:flutter/material.dart';

class MyPlansView extends StatefulWidget {
  const MyPlansView({super.key});

  @override
  State<MyPlansView> createState() => _MyPlansViewState();
}

class _MyPlansViewState extends State<MyPlansView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('My Plans View')),
    );
  }
}
