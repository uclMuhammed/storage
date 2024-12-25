import 'package:flutter/material.dart';

enum NotificationType {
  error(Colors.redAccent, Icons.error_outline),
  warning(Colors.orangeAccent, Icons.warning_amber_outlined),
  success(Colors.greenAccent, Icons.check_circle_outline),
  info(Colors.blueAccent, Icons.info_outline);

  final Color color;
  final IconData icon;
  const NotificationType(this.color, this.icon);
}

extension Errors on BuildContext {
  void showNotification({
    required String message,
  }) {}
}
