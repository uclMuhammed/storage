import 'package:flutter/material.dart';

import '../auth/login/login_view.dart';
import '../auth/signup/signup_view.dart';
import '../home/home_view.dart';
import '../home/profile/profile_view.dart';
import '../welcome/welcome.dart';

import 'app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (context) => const Welcome(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
          settings: settings,
        );
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (context) => const SignupView(),
          settings: settings,
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Welcome(),
          settings: settings,
        );
    }
  }
}
