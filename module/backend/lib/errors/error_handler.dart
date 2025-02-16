import 'package:backend/implement/service_auth_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'api_exception.dart';
import 'error_codes.dart';

class ErrorHandler {
  // Singleton pattern
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  // Global error handling
  Future<T> handleError<T>({
    required Future<T> Function() operation,
    required BuildContext context,
    String? customMessage,
    bool showDialog = true,
    VoidCallback? onError,
  }) async {
    try {
      return await operation();
    } on ApiException catch (e) {
      if (kDebugMode) {
        print('API Error: ${e.toString()}');
      }

      if (showDialog) {
        _showErrorDialog(context, e.message);
      }

      _handleSpecificError(context, e);
      onError?.call();
      rethrow;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Unexpected Error: $e\n$stackTrace');
      }

      final apiException = ApiException(
        errorCode: ApiErrorCode.unknown,
        customMessage: customMessage ?? 'Beklenmeyen bir hata oluştu',
        metaData: {'originalError': e.toString()},
      );

      if (showDialog) {
        _showErrorDialog(context, apiException.message);
      }

      onError?.call();
      throw apiException;
    }
  }

  void _handleSpecificError(BuildContext context, ApiException error) {
    switch (error.errorCode) {
      case ApiErrorCode.unauthorized:
      case ApiErrorCode.tokenExpired:
        // Önce storage'ı temizle
        ServiceAuthClient().logout();
        // Login sayfasına yönlendir ve tüm stack'i temizle
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false, // tüm route stack'i temizle
        );
        break;

      case ApiErrorCode.networkError:
        // Ağ bağlantısı kontrolü
        _showNetworkErrorDialog(context);
        break;

      default:
        // Diğer hataları normal dialog ile göster
        break;
    }
  }

  Future<void> _showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hata'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  Future<void> _showNetworkErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bağlantı Hatası'),
        content:
            const Text('İnternet bağlantınızı kontrol edip tekrar deneyiniz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
