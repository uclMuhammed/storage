import 'package:backend/backend.dart';
import 'package:flutter/material.dart';

class RouteController extends IRouteController {
  final Widget notFoundPage;
  final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'RouteController NavigatorKey');

  RouteController({required this.notFoundPage, required super.routes});
  // ------------------------------------------------------------
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  // ------------------------------------------------------------
  @override
  Route onGenerateRoute(RouteSettings settings) {
    for (var route in routes.entries) {
      if (route.key.routeName == settings.name) {
        return MaterialPageRoute(builder: route.value, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (context) => notFoundPage, settings: settings);
  }
}
