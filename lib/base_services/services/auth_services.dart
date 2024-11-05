import 'package:backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final HttpManager stockAuthManager = HttpManager(
  baseUrl: stockTrackerAuthUrl,
  headers: stockApiHeader,
);

Future<void> register(String name, String email, String password) async {
  try {
    stockAuthManager.addInterceptor(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    final response = await stockAuthManager.post('/register', body: {
      'companyName': name,
      'email': email,
      'password': password,
    });
  } on DioException catch (e) {
    print('Dio hatası: ${e.message}');
  } catch (e) {
    print('Genel hata: $e');
  }
}

Future<void> login(int code, String email, String password) async {
  try {
    stockAuthManager.addInterceptor(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    final response = await stockAuthManager.post('/login', body: {
      'companyCode': code,
      'email': email,
      'password': password,
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', response.data['token']);
    print(response);
  } on DioException catch (e) {
    print('Dio hatası: ${e.message}');
  } catch (e) {
    print('Genel hata: $e');
  }
}
