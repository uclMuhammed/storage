import 'package:backend/backend.dart';
import 'package:core/base/warehouses/warehouses.dart';
import 'package:dio/dio.dart';

final HttpManager stockTrackerManager = HttpManager(
  baseUrl: stockTrackerApiUrl,
  headers: stockApiHeader,
);

class Warehousesservices {
  Future<List<Warehouses>> getWarehouses() async {
    try {
      final response = await stockTrackerManager.get('/warehouses');
      return (response.data as List).map((e) => Warehouses.fromJson(e)).toList();
    } on DioError catch (e) {
      print('Dio hatası: ${e.message}');
    } catch (e) {
      print('Genel hata: $e');
    }
    return [];
  }

  Future<List<Warehouses>> getWarehousesByCode(int code) async {
    try {
      final response = await stockTrackerManager.get('/warehouses/$code');
      return (response.data as List).map((e) => Warehouses.fromJson(e)).toList();
    } on DioError catch (e) {
      print('Dio hatası: ${e.message}');
    } catch (e) {
      print('Genel hata: $e');
    }
    return [];
  }

  Future<List<Warehouses>> getWarehousesByName(String name) async {
    try {
      final response = await stockTrackerManager.get('/warehouses/$name');
      return (response.data as List).map((e) => Warehouses.fromJson(e)).toList();
    } on DioError catch (e) {
      print('Dio hatası: ${e.message}');
    } catch (e) {
      print('Genel hata: $e');
    }
    return [];
  }
}
