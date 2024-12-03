import 'package:flutter/material.dart';
import 'package:storage/deneme/category.dart';
import 'package:storage/deneme/productScreen.dart';
import 'package:storage/pages/auth/auth_page.dart';
import 'package:storage/pages/brands/brands.dart';
import 'package:storage/pages/products/products.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stok Uygulaması',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
