abstract class HttpClient {
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String endPoint, {Map<String, dynamic>? body});
  Future<dynamic> getById(String endPoint, String id);
  Future<dynamic> put(String endPoint, String id, {Map<String, dynamic>? body});
  Future<dynamic> delete(String endPoint, String id);
}
