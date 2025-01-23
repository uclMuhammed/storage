import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'features/routes/route_constants.dart';
import 'features/routes/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// Test
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TokenActivityStateProvider(
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteManager.onGenerateRoute,
        initialRoute: RouteConstants.home,
      ),
    );
  }
}
