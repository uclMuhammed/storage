import 'package:flutter/material.dart';
import 'package:storage/view/pages/welcome/welcome_mixin.dart';
import '../../view/pages/welcome/welcome_view.dart';

class RouteManager {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/welcome': (context) => WelcomePage(viewModel: WelcomePageMixin()),
    /* '/': (context) => const HomePage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/profile': (context) => const ProfilePage(),
    '/settings': (context) => const SettingsPage(), */
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Route parametrelerini al
    final args = settings.arguments;
    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(
          builder: (context) => WelcomePage(viewModel: WelcomePageMixin()),
        );
      default:
        return _errorRoute();
    }

    /*    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      
      case '/profile':
        return MaterialPageRoute(
          builder: (context) => ProfilePage(
            userId: args is String ? args : null,
          ),
        );
      
      case '/settings':
        return MaterialPageRoute(
          builder: (context) => const SettingsPage(),
          fullscreenDialog: true,
        );

      default:
        return _errorRoute();
    } */
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Hata'),
        ),
        body: const Center(
          child: Text('Sayfa bulunamadı!'),
        ),
      ),
    );
  }

  // Navigation yardımcı metodları
  static Future<T?> navigateTo<T>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<T?> navigateToReplacement<T>(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments);
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
