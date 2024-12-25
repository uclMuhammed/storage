import 'package:flutter/material.dart';
import 'package:storage/auth/login/login_view.dart';
import 'package:storage/auth/signup/signup_view.dart';

import '../auth/auth_view.dart';
import '../home/home_view.dart';
import 'app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (context) => const AuthView(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (context) => const LoginView(), fullscreenDialog: true);
      case AppRoutes.signup:
        return MaterialPageRoute(
            builder: (context) => const SignupView(), fullscreenDialog: true);
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (_) => const HomeView(), fullscreenDialog: true);
      default:
        return MaterialPageRoute(
            builder: (_) => const AuthView(), fullscreenDialog: true);
    }
  }
}
