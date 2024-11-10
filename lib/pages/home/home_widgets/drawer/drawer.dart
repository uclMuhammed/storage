import 'package:backend/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import 'package:storage/pages/auth/auth_page.dart';
import 'package:storage/pages/home/home_widgets/drawer/managment/managment.dart';
import 'package:storage/pages/home/home_widgets/drawer/warehouse/warehouse.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/buttons/shortcutButtun.dart';

class MyDrawer extends StatefulWidget {
  final AuthManager authManager;
  const MyDrawer({super.key, required this.authManager});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

AuthenticationService auth = AuthenticationService();

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return Drawer(
          child: Column(
            children: [
              SizedBox(height: size.maxHeight * 0.4),
              ShortcutButtun(
                icon: Icons.warehouse,
                text: "D E P O L A R I M",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WareHouse(),
                    ),
                  );
                },
              ),
              ShortcutButtun(
                icon: Icons.person_add,
                text: "Y Ö N E T İ M",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Managment(
                        authManager: widget.authManager,
                      ),
                    ),
                  );
                },
              ),
              ShortcutButtun(
                icon: Icons.settings,
                text: "A Y A R L A R",
                onPressed: () {},
              ),
              const Spacer(),
              ShortcutButtun(
                icon: Icons.logout,
                text: "Ç I K I Ş  Y A P",
                onPressed: () {},
              ),
            ],
          ).paddingAll(16),
        );
      },
    );
  }

  showSnackBar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> logout() async {
    await widget.authManager.logout();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
      );
    }
  }
}
