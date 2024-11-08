import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:backend/backend.dart';
import 'package:dio/dio.dart';
import 'package:storage/base_services/base_service.dart';

class AuthService extends BaseService {
  String endPointLogin = '/login';
  String endPointRegister = '/register';

  AuthService()
      : super(
          baseUrl: stockTrackerAuthUrl,
          headers: stockApiHeader,
        );

  Future<void> login(int code, String email, String password) async {
    try {
      httpManager.addInterceptor(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (object) => print(object),
        ),
      );
      final body = {"companyCode": code, "email": email, "password": password};
      final response = await get(endPointLogin, queryParameters: body);
      print(response.data);
    } on DioException catch (e) {
      print("Genel hata:" + e.toString());
    } catch (e) {
      print("normal hata: " + e.toString());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {} on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
