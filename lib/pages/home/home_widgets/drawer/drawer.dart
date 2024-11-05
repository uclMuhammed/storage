import 'package:flutter/material.dart';
import 'package:storage/pages/home/home_widgets/drawer/warehouse/warehouse.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/buttons/shortcutButtun.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

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
                onPressed: () {},
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
}
