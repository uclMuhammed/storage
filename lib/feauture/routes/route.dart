import 'package:backend/backend.dart';
import 'package:flutter/material.dart';

import '../../view/index.dart';

RouteController routeController = RouteController(
  notFoundPage: const NotFoundPage(),
  routes: routes,
);

final Map<Routes, Widget Function(BuildContext context)> routes = {
  Routes.welcome: (context) => const WelcomeView(),
};
