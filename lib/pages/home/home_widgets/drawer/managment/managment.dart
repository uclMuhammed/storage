import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';

class Managment extends StatefulWidget {
  final AuthManager authManager;
  const Managment({super.key, required this.authManager});

  @override
  State<Managment> createState() => _ManagmentState();
}

class _ManagmentState extends State<Managment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yönetim"),
        actions: const [],
      ),
    );
  }
}
