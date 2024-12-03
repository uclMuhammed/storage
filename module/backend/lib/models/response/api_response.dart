class ApiResponse<T> {
  final String status;
  final String message;
  final T data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    // Hata kontrolü
    final data = json['data'];
    if (data is List && data.isNotEmpty) {
      final firstItem = data[0];
      if (firstItem is Map<String, dynamic>) {
        // HasError kontrolü
        final hasError = firstItem['HasError'];
        if (hasError == true) {
          final errorMessage = firstItem['Message'];
          throw Exception(errorMessage);
        }
      }
    }

    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: fromJsonT(data),
    );
  }
}
