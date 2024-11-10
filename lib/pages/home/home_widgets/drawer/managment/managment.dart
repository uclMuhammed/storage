import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import '../../../../../authority_manager/authority_type_implementations.dart';

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
        actions: [
          if (widget.authManager.userAuthority != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AuthorityBadge(authority: widget.authManager.userAuthority!),
            ),
        ],
      ),
    );
  }
}
