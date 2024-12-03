class InfoResponse {
  final int companyUserId;
  final String message;
  final bool hasError;

  InfoResponse({
    required this.companyUserId,
    required this.message,
    required this.hasError,
  });

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(
      companyUserId: json['CompanyUserId'],
      message: json['Message'],
      hasError: json['HasError'],
    );
  }
}
