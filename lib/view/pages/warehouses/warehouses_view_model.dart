import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class WarehousesViewModel extends BaseViewModel {
  // Key
  final Key viewKey = const Key('_warehouses_view_key');

  // Service Auth Client
  final _authClient = ServiceAuthClient();

  // Service
  ServiceApiClient? serviceApiClient;
  ServiceApiClient? regionService;
  ServiceApiClient? cityService;

  // ValueNotifier
  final ValueNotifier<List<Warehouses>> warehouses = ValueNotifier([]);
  final ValueNotifier<Warehouses?> selectedWarehouseNotifier =
      ValueNotifier(null);

  @override
  void init() {
    _authClient.init();
    _initServiceApiClient();
  }

  Future<void> _initServiceApiClient() async {
    final token = await _authClient.getAuthToken();
    serviceApiClient = ServiceApiClient(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/warehouses',
      fromJson: (Map<String, dynamic> json) => Warehouses.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();
  }

  Future<List<IModel>> getAllWarehouses() async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }
      final response = await serviceApiClient!.getAll();

      // İlk depo seçimini burada yapalım
      if (selectedWarehouseNotifier.value == null && response.isNotEmpty) {
        selectedWarehouseNotifier.value = response.first as Warehouses;
      }

      return response;
    } catch (e) {
      print('Warehouses getirme hatası: $e');
      return [];
    }
  }

  @override
  void dispose() {
    serviceApiClient?.dispose();
    super.dispose();
  }

  // Depo Silme
  Future<bool> deleteWarehouse(int warehouseId) async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }

      final response = await serviceApiClient?.deleteById(warehouseId) ?? false;
      if (response) {
        // Başarılı silme durumunda listeyi güncelle
        final updatedList = await getAllWarehouses();
        warehouses.value = updatedList.map((e) => e as Warehouses).toList();

        // Seçili depo silindiyse seçimi kaldır
        if (selectedWarehouseNotifier.value?.id == warehouseId) {
          selectedWarehouseNotifier.value = null;
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Depo silme hatası: $e');
      return false;
    }
  }

  // Depo Güncelleme
  Future<bool> updateWarehouse(Warehouses warehouse) async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }

      final response =
          await serviceApiClient?.updateById(warehouse.warehouse, warehouse) ??
              false;
      if (response == true) {
        // Başarılı güncelleme durumunda listeyi yenile
        final updatedList = await getAllWarehouses();
        warehouses.value = updatedList.map((e) => e as Warehouses).toList();

        // Seçili depo güncellendiyse onu da güncelle
        if (selectedWarehouseNotifier.value?.id == warehouse.id) {
          selectedWarehouseNotifier.value = warehouse;
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Depo güncelleme hatası: $e');
      return false;
    }
  }

  // Depo Oluşturma
  Future<bool> createWarehouse(Warehouses warehouse) async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }

      final response = await serviceApiClient?.create(warehouse) ?? false;
      if (response == true) {
        // Başarılı oluşturma durumunda listeyi yenile
        final updatedList = await getAllWarehouses();
        warehouses.value = updatedList.map((e) => e as Warehouses).toList();
        return true;
      }
      return false;
    } catch (e) {
      print('Depo oluşturma hatası: $e');
      return false;
    }
  }

  // Depo Arama
  void searchWarehouses(String query) async {
    try {
      final allWarehouses = await getAllWarehouses();
      if (query.isEmpty) {
        warehouses.value = allWarehouses.map((e) => e as Warehouses).toList();
        return;
      }

      final filteredList = allWarehouses.where((warehouse) {
        final w = warehouse as Warehouses;
        return w.description.toLowerCase().contains(query.toLowerCase()) ||
            w.warehouse.toString().contains(query) ||
            w.address.toLowerCase().contains(query.toLowerCase());
      }).toList();

      warehouses.value = filteredList.map((e) => e as Warehouses).toList();
    } catch (e) {
      print('Depo arama hatası: $e');
    }
  }
}
