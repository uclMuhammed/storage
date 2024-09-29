import 'package:flutter/material.dart';
import 'package:storage/pages/storage_list_page/storage_page.dart';

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
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: StorageScreen(),
    );
  }
}
