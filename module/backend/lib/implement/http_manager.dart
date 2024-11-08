import 'package:backend/abstract/http_client.dart';
import 'package:dio/dio.dart';

class HttpManager implements HttpClient {
  final Dio _dio;

  HttpManager({required String baseUrl, required Map<String, dynamic> headers})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: headers,
        ));

  @override
  Future<Response> get(String endPoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endPoint, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    } catch (e) {
      rethrow;
    } finally {}
  }

  @override
  Future<Response> getById(String endPoint, String id) async {
    try {
      final response = await _dio.get('$endPoint/$id');
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    } catch (e) {
      rethrow;
    } finally {}
  }

  @override
  Future<Response<dynamic>> post(String endPoint, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post(
        endPoint,
        data: body,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.headers);
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    } catch (e) {
      rethrow;
    } finally {}
  }

  @override
  Future<Response> put(String endPoint, String id, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.put(
        '$endPoint/$id',
        data: body,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    } catch (e) {
      rethrow;
    } finally {}
  }

  @override
  Future<Response> delete(String endPoint, String id) async {
    try {
      final response = await _dio.delete('$endPoint/$id');
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    } catch (e) {
      rethrow;
    } finally {}
  }

  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception('Bağlantı zaman aşımına uğradı');
      case DioExceptionType.sendTimeout:
        throw Exception('Veri gönderme zaman aşımına uğradı');
      case DioExceptionType.receiveTimeout:
        throw Exception('Veri alma zaman aşımına uğradı');
      case DioExceptionType.badResponse:
        throw Exception('Sunucudan hatalı yanıt: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        throw Exception('İstek iptal edildi');
      default:
        throw Exception('Bir ağ hatası oluştu: ${e.message}');
    }
  }

  dynamic _handleResponse(Response response) {
    final statusCode = response.statusCode;

    if (statusCode == null) {
      throw Exception('Status code alınamadı');
    }

    if (statusCode >= 200 && statusCode < 300) {
      // response.data zaten JSON olarak parse edilmiş geliyor
      return response.data;
    } else if (statusCode >= 400 && statusCode < 500) {
      throw Exception('İstek hatası: $statusCode - ${response.statusMessage}');
    } else if (statusCode >= 500) {
      throw Exception('Sunucu hatası: $statusCode - ${response.statusMessage}');
    } else {
      throw Exception('Beklenmeyen durum kodu: $statusCode');
    }
  }

  // İsteğe bağlı: Interceptor ekleyebilirsiniz
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
