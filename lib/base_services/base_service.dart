import 'package:backend/implement/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  final HttpManager httpManager;
  String? _userToken;

  BaseService({required String baseUrl, required Map<String, dynamic> headers})
      : httpManager = HttpManager(
          baseUrl: baseUrl,
          headers: headers,
        ) {
    _loadUserToken();
  }

  Future<void> _loadUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    _userToken = prefs.getString('token');
    httpManager.addInterceptor(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_userToken != null) {
            options.headers['Authorization'] = 'Bearer $_userToken';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _userToken = token;
    httpManager.addInterceptor(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $_userToken';
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await httpManager.get(path, queryParameters: queryParameters);
  }

  Future<Response<dynamic>> post(String path, {Map<String, dynamic>? body}) async {
    return await httpManager.post(path, body: body);
  }

  Future<Response<dynamic>> put(String path, String id, {dynamic body}) async {
    return await httpManager.put(path, id, body: body);
  }

  Future<Response<dynamic>> delete(String path, String id) async {
    return await httpManager.delete(path, id);
  }
}
