import 'package:flutter/material.dart';
import 'package:storage/view/pages/home/home_view.dart';
import 'package:storage/view/welcome/welcome_view_model.dart';
import 'package:storage/view/auth/login/login_view_model.dart';
import '../../view/auth/signup/signup_view.dart';
import '../../view/auth/signup/signup_view_model.dart';
import '../../view/welcome/welcome_view.dart';
import '../../view/auth/login/login_view.dart';

class RouteManager {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/welcome': (context) =>
        WelcomeView(viewModel: WelcomeViewModel(), body: WelcomeBody()),
    '/login': (context) => LoginView(
          viewModel: LoginViewModel(),
          body: LoginBody(),
        ),
    '/signup': (context) =>
        SignupView(viewModel: SignupViewModel(), body: SignupBody()),
    '/home': (context) => const HomeView(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Route parametrelerini al

    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(
          builder: (context) =>
              WelcomeView(viewModel: WelcomeViewModel(), body: WelcomeBody()),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) =>
              LoginView(viewModel: LoginViewModel(), body: LoginBody()),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) =>
              SignupView(viewModel: SignupViewModel(), body: SignupBody()),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      default:
        return _errorRoute();
    }
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
