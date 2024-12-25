import 'package:flutter/foundation.dart';

class ApiResponse<T> {
  final dynamic status;
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
    // Debug için gelen json yapısını yazdıralım
    if (kDebugMode) {
      print('Raw API Response JSON: $json');
    }

    // status ve message alanlarını al
    final status = json['status'] ?? json['Status'];
    final message =
        json['message']?.toString() ?? json['Message']?.toString() ?? '';
    final responseData = json['data'] ?? json['Data'];

    if (kDebugMode) {
      print('Status: $status');
      print('Message: $message');
      print('Response Data: $responseData');
    }

    // responseData null kontrolü
    if (responseData == null) {
      throw Exception('API yanıtında data yok');
    }

    try {
      // Map kontrolü - Tek kayıt durumu
      if (responseData is Map<String, dynamic>) {
        // Hata kontrolü
        if (responseData['HasError'] == true ||
            responseData['hasError'] == true) {
          throw Exception(responseData['Message'] ??
              responseData['message'] ??
              'Bir hata oluştu');
        }
        // Tek kayıt parse
        return ApiResponse(
            status: status, message: message, data: fromJsonT(responseData));
      }

      // Liste kontrolü - Çoklu kayıt durumu
      if (responseData is List) {
        // Boş liste kontrolü
        if (responseData.isEmpty) {
          return ApiResponse(
              status: status, message: message, data: fromJsonT(responseData));
        }
        // Liste içerik parse
        return ApiResponse(
            status: status, message: message, data: fromJsonT(responseData));
      }

      if (T == bool) {
        if (responseData is Map<String, dynamic> &&
            responseData['HasError'] == true) {
          return ApiResponse(
            status: false,
            message: responseData['Message'] ?? 'İşlem başarısız',
            data: false as T,
          );
        }

        return ApiResponse(
          status: true,
          message: message,
          data: true as T,
        );
      }

      // Diğer tip veriler için genel parse
      return ApiResponse(
        status: status,
        message: message,
        data: fromJsonT(responseData),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Parse Error: $e');
      }
      throw Exception('Veri dönüşüm hatası: $e');
    }
  }
}
