import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Products> _productsService;
  late final SmartApiService<Warehouses> _warehousesService;
  late final SmartApiService<Categories> _categoriesService;
  late final SmartApiService<Suppliers> _suppliersService;
  bool _isInitialized = false;

  // ValueNotifier'lar
  final products = ValueNotifier<List<Products>>([]);
  final warehouses = ValueNotifier<List<Warehouses>>([]);
  final categories = ValueNotifier<List<Categories>>([]);
  final suppliers = ValueNotifier<List<Suppliers>>([]);
  final error = ValueNotifier<String?>(null);
  final loadingNotifier = ValueNotifier<bool>(false);
  final refreshTrigger = ValueNotifier<bool>(false);

  @override
  bool get isLoading => loadingNotifier.value;
  set isLoading(bool value) {
    loadingNotifier.value = value;
    if (value) error.value = null;
  }

  @override
  void init() {
    _initServices().then((_) => _loadData());
    refreshTrigger.addListener(_loadData);
  }

  Future<void> _initServices() async {
    if (_isInitialized) return;
    try {
      _serviceAuthClient = ServiceAuthClient()..init();
      final token = await _serviceAuthClient.getToken();
      if (token == null) throw Exception('Oturum açmanız gerekiyor');

      _productsService = SmartApiService<Products>(
        fromJson: Products.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.products,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _warehousesService = SmartApiService<Warehouses>(
        fromJson: Warehouses.fromJson,
        toJson: (w) => w.toJson(),
        endPoint: ApiEndpoints.warehouses,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _categoriesService = SmartApiService<Categories>(
        fromJson: Categories.fromJson,
        toJson: (c) => c.toJson(),
        endPoint: ApiEndpoints.categories,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _suppliersService = SmartApiService<Suppliers>(
        fromJson: Suppliers.fromJson,
        toJson: (s) => s.toJson(),
        endPoint: ApiEndpoints.suppliers,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _isInitialized = true;
    } catch (e) {
      error.value = 'Servis başlatılamadı: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      isLoading = true;

      final productsData =
          await _productsService.getAll(priority: CachePriority.high);
      products.value = productsData;

      final warehousesData =
          await _warehousesService.getAll(priority: CachePriority.high);
      warehouses.value = warehousesData;

      final categoriesData =
          await _categoriesService.getAll(priority: CachePriority.high);
      categories.value = categoriesData;

      final suppliersData =
          await _suppliersService.getAll(priority: CachePriority.high);
      suppliers.value = suppliersData;
    } catch (e) {
      error.value = 'Veriler yüklenemedi: $e';
    } finally {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    products.dispose();
    warehouses.dispose();
    categories.dispose();
    suppliers.dispose();
    error.dispose();
    loadingNotifier.dispose();
    refreshTrigger.dispose();
    super.dispose();
  }
}
