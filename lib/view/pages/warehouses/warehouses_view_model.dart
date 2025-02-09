import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class WarehousesViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Warehouses> _warehousesService;
  late final SmartApiService<Regions> _regionsService;
  late final SmartApiService<Cities> _citiesService;
  bool _isInitialized = false;

  final warehouses = ValueNotifier<List<Warehouses>>([]);
  final regions = ValueNotifier<List<Regions>>([]);
  final cities = ValueNotifier<List<Cities>>([]);

  final selectedWarehouse = ValueNotifier<Warehouses?>(null);
  final selectedRegion = ValueNotifier<Regions?>(null);
  final selectedCity = ValueNotifier<Cities?>(null);

  final loadingNotifier = ValueNotifier<bool>(false);
  final error = ValueNotifier<String?>(null);

  @override
  bool get isLoading => loadingNotifier.value;

  @override
  void setLoading(bool value) {
    loadingNotifier.value = value;
    if (value) error.value = null;
    notifyListeners();
  }

  @override
  void init() {
    _initServices().then((_) => _loadData());
  }

  Future<void> _initServices() async {
    if (_isInitialized) return;
    try {
      _serviceAuthClient = ServiceAuthClient()..init();
      final token = await _serviceAuthClient.getToken();
      if (token == null) throw Exception('Oturum açmanız gerekiyor');

      _warehousesService = SmartApiService<Warehouses>(
        fromJson: Warehouses.fromJson,
        toJson: (w) => w.toJson(),
        endPoint: ApiEndpoints.warehouses,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      );

      _regionsService = SmartApiService<Regions>(
        fromJson: Regions.fromJson,
        toJson: (r) => r.toJson(),
        endPoint: ApiEndpoints.regions,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      );

      _citiesService = SmartApiService<Cities>(
        fromJson: Cities.fromJson,
        toJson: (c) => c.toJson(),
        endPoint: ApiEndpoints.cities,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      );

      _isInitialized = true;
    } catch (e) {
      error.value = 'Servis başlatılamadı: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      setLoading(true);

      final data =
          await _warehousesService.getAll(priority: CachePriority.high);
      warehouses.value = data;

      final regionsData =
          await _regionsService.getAll(priority: CachePriority.high);
      regions.value = regionsData;

      final citiesData =
          await _citiesService.getAll(priority: CachePriority.high);
      cities.value = citiesData;

      if (data.isNotEmpty && selectedWarehouse.value == null) {
        selectedWarehouse.value = data.first;
      }
    } catch (e) {
      error.value = 'Veriler yüklenemedi: $e';
      warehouses.value = [];
      selectedWarehouse.value = null;
    } finally {
      setLoading(false);
    }
  }

  Future<void> createWarehouse(
      String description, int regionId, int cityId, String address) async {
    try {
      setLoading(true);
      final warehouse =
          Warehouses.insert(description, regionId, cityId, address);
      final created = await _warehousesService.create(warehouse);
      await _loadData();
      selectedWarehouse.value = warehouses.value.firstWhere(
        (w) => w.id == created.id,
        orElse: () => created,
      );
    } catch (e) {
      error.value = 'Depo oluşturulamadı: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateWarehouse(
      String description, int regionId, int cityId, String address) async {
    try {
      setLoading(true);
      final warehouse =
          Warehouses.insert(description, regionId, cityId, address);
      await _warehousesService.updateById(
          selectedWarehouse.value!.id!, warehouse);
      await _loadData();
      if (selectedWarehouse.value != null) {
        selectedWarehouse.value = warehouses.value.firstWhere(
          (w) => w.id == selectedWarehouse.value!.id,
          orElse: () => Warehouses.empty(),
        );
      }
    } catch (e) {
      error.value = 'Depo güncellenemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteWarehouse(int id) async {
    try {
      setLoading(true);
      await _warehousesService.deleteById(id);
      await _loadData();
      if (selectedWarehouse.value?.id == id) {
        selectedWarehouse.value =
            warehouses.value.isNotEmpty ? warehouses.value.first : null;
      }
    } catch (e) {
      error.value = 'Depo silinemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    warehouses.dispose();
    selectedWarehouse.dispose();
    loadingNotifier.dispose();
    error.dispose();
    regions.dispose();
    cities.dispose();
    selectedRegion.dispose();
    selectedCity.dispose();
    super.dispose();
  }
}
