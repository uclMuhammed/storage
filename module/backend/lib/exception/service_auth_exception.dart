class AuthException implements Exception {
  final String message;
  final int statusCode;
  final StackTrace stackTrace;
  final String operation;

  AuthException({
    required this.message,
    required this.statusCode,
    required this.stackTrace,
    required this.operation,
  });

  @override
  String toString() => 'AuthException: $message';
}

class AuthExceptionOnInit extends AuthException {
  final String type;
  final String name;

  AuthExceptionOnInit({
    required super.message,
    required super.statusCode,
    required super.stackTrace,
    required super.operation,
    required this.type,
    required this.name,
  });
}
