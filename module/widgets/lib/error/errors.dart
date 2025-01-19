import 'package:flutter/material.dart';

// Bildirim türleri için enum
enum NotificationType {
  error(Colors.redAccent, Icons.error_outline),
  warning(Colors.orangeAccent, Icons.warning_amber_outlined),
  success(Colors.greenAccent, Icons.check_circle_outline),
  info(Colors.blueAccent, Icons.info_outline);

  final Color color;
  final IconData icon;
  const NotificationType(this.color, this.icon);
}

// BuildContext extension
extension ErrorHandling on BuildContext {
  void showNotification( {
    required String message,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(type.icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: type.color,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: 'Kapat',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Dialog gösterme extension'ı
  Future<bool?> showErrorDialog({
    required String title,
    required String message,
    String? primaryButtonText,
    String? secondaryButtonText,
  }) {
    return showDialog<bool>(
      context: this,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (secondaryButtonText != null)
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(secondaryButtonText),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(primaryButtonText ?? 'Tamam'),
          ),
        ],
      ),
    );
  }

  // Loading gösterme extension'ı
  void showLoading() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  // Loading kapatma extension'ı
  void hideLoading() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }
}

// Try-catch wrapper için extension
extension ErrorWrapper on Future Function() {
  Future<void> withErrorHandler(BuildContext context) async {
    try {
      context.showLoading();
      await this();
      context.hideLoading();
    } catch (e) {
      context.hideLoading();
      context.showNotification(
        message: e.toString(),
        type: NotificationType.error,
      );
    }
  }
}