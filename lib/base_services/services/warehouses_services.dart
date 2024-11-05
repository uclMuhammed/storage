import 'package:backend/backend.dart';
import 'package:core/base/warehouses/warehouses.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/base_services/base_service.dart';

class WarehousesServices {
  String endpoint = '/warehouses';

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
  /*
  final HttpManager stockManager = HttpManager(
    baseUrl: stockTrackerApiUrl,
    headers: headerWithToken(),
  );
   Future<void> addWarehouses() async {
    stockManager.addInterceptor(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    try {
      final response = await stockManager.post(endpoint, body: {
        'warehouse': 1,
        'description': 'test',
      });
      print(response);
    } on DioException catch (e) {
      print('Dio hatası: ${e.message}');
    } catch (e) {
      print('Genel hata: $e');
    }
  }

  Future<List<Warehouses>> getWarehouses() async {
    stockManager.addInterceptor(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    try {
      final dynamic response = await stockManager.get(endpoint);
      return response.map((e) => Warehouses.fromJson(e)).toList();
    } on DioException catch (e) {
      print('Dio hatası: ${e.message}');
    } catch (e) {
      print('Genel hata: $e');
    }
    return [];
  }
 */
}
