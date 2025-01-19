import 'package:backend/backend.dart';
import 'package:flutter/material.dart';

abstract class IRouteController {
  GlobalKey<NavigatorState> get navigatorKey;
  final Map<Routes, Widget Function(BuildContext context)> routes;

  IRouteController({required this.routes});

  Route<dynamic> onGenerateRoute(RouteSettings settings);
}
