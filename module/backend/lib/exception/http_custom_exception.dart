class HttpCustomException implements Exception {
  final int statusCode;
  final String message;

  HttpCustomException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => 'Http Custom Exception: $statusCode - $message';
}
