import 'package:backend/backend.dart';
import 'package:flutter/material.dart';

import 'feauture/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// Test
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: routeController.navigatorKey,
      onGenerateRoute: routeController.onGenerateRoute,
      initialRoute: Routes.welcome.routeName,
      scrollBehavior: CustomScrollBehavior(),
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
