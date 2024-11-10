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
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: fromJsonT(json['data'] ?? []),
    );
  }
}
