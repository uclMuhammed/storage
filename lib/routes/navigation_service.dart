import 'package:flutter/material.dart';
import 'package:storage/home/admin_panel/admin_panel_view.dart';

import '../auth/login/login_view.dart';
import '../auth/signup/signup_view.dart';
import '../home/home_view.dart';
import '../home/profile/profile_view.dart';
import '../welcome/welcome_view.dart';

import 'app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(
          builder: (context) => const WelcomeView(),
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
      case AppRoutes.adminPanel:
        return MaterialPageRoute(
          builder: (_) => const AdminPanelView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const WelcomeView(),
          settings: settings,
        );
    }
  }
}
