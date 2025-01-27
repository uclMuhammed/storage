class UnauthorizedException implements Exception {
  final String message;
  final int statusCode;
  final StackTrace stackTrace;

  UnauthorizedException({
    required this.message,
    required this.statusCode,
    required this.stackTrace,
  });

  @override
  String toString() => 'UnauthorizedException: $message';
}
