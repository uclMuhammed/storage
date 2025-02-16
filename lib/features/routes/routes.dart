import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:storage/view/welcome/welcome_view.dart';

import '../../view/auth/login/login_view.dart';
import '../../view/auth/signup/signup_view.dart';
import '../../view/home/home_view.dart';

final routeController = RouteController(
  notFoundPage: const Center(child: Text('Sayfa Bulunamadı')),
  routes: {
    Routes.welcome: (context) => WelcomeView(),
    Routes.home: (context) => const HomeView(),
    Routes.login: (context) => const LoginView(),
    Routes.register: (context) => SignupView(),
    Routes.forgotPassword: (context) => Container(),
  },
);
