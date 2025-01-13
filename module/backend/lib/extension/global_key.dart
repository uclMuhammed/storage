import 'package:backend/backend.dart';
import 'package:flutter/material.dart';

extension FormStateExtension on GlobalKey<FormState> {
  bool get isNullState {
    return currentState == null;
  }

  bool get isValidate {
    if (isNullState) return false;
    return currentState!.validate();
  }

  bool get isMounted {
    if (isNullState) return false;
    return currentState!.context.mounted;
  }
}

extension NavigatorStateExtension on GlobalKey<NavigatorState> {
  bool get isNullState {
    return currentState == null;
  }

  bool get isMounted {
    if (isNullState) return false;
    return currentState!.context.mounted;
  }

  Future<T?> pushNamed<T extends Object?>(Routes route,
      {Object? arguments}) async {
    if (isNullState) return null;
    if (!isMounted) return null;
    return await currentState!.pushNamed(route.name, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?>(Routes route,
      {Object? arguments}) async {
    if (isNullState) return null;
    if (!isMounted) return null;
    return await currentState!
        .pushReplacementNamed(route.routeName, arguments: arguments);
  }
}
