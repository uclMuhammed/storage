import 'package:backend/backend.dart';
import 'error_codes.dart';

class ApiException extends IException {
  final ApiErrorCode errorCode;

  ApiException({
    required this.errorCode,
    String? customMessage,
    super.metaData,
  }) : super(
          message: customMessage ?? errorCode.message,
          statusCode: errorCode.code,
          stackTrace: StackTrace.current,
          name: 'ApiException',
          type: 'API_ERROR',
          operation: 'API_CALL',
        );

  factory ApiException.fromStatusCode(
    int statusCode, {
    String? customMessage,
    Map<String, dynamic>? metaData,
  }) {
    final errorCode = ApiErrorCode.values.firstWhere(
      (e) => e.code == statusCode,
      orElse: () => ApiErrorCode.unknown,
    );

    return ApiException(
      errorCode: errorCode,
      customMessage: customMessage,
      metaData: metaData,
    );
  }

  factory ApiException.fromJson(Map<String, dynamic> json) {
    final statusCode = json['statusCode'] as int;
    return ApiException.fromStatusCode(
      statusCode,
      customMessage: json['message'] as String?,
      metaData: json['metaData'] as Map<String, dynamic>?,
    );
  }
}
