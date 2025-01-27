import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:storage/features/routes/routes.dart';
import 'package:storage/view/pages/home/home_view.dart';

// AppInterceptors'dan navigator key'i alalım

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ServiceAuthClient'i başlat ve token kontrolü yap
  final authClient = ServiceAuthClient();
  await authClient.init();

  // Token kontrolü
  final isAuthenticated = await authClient.isAuthenticated();

  runApp(MyApp(
    navigatorKey: routeController.navigatorKey,
    initialRoute:
        isAuthenticated ? Routes.home.routeName : Routes.login.routeName,
  ));
}

// Test
class MyApp extends StatelessWidget {
  final String initialRoute;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    super.key,
    required this.initialRoute,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return TokenActivityStateProvider(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scrollBehavior: CustomScrollBehavior(),
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routeController.onGenerateRoute,
        initialRoute: initialRoute,
        home: HomeView(),
      ),
    );
  }
}
