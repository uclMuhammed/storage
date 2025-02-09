import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class SuppliersViewModel extends BaseViewModel {
  // API Services
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Suppliers> _suppliersService;
  late final SmartApiService<Regions> _regionsService;
  bool _isInitialized = false;

  // State Management
  final suppliers = ValueNotifier<List<Suppliers>>([]);
  final selectedSupplier = ValueNotifier<Suppliers?>(null);
  final _loadingNotifier = ValueNotifier<bool>(false);
  final error = ValueNotifier<String?>(null);
  final refreshTrigger = ValueNotifier<bool>(false);
  final regions = ValueNotifier<List<Regions>>([]);

  // Getters
  ValueNotifier<bool> get loadingNotifier => _loadingNotifier;
  SmartApiService<Suppliers> get suppliersService => _suppliersService;
  SmartApiService<Regions> get regionsService => _regionsService;

  @override
  bool get isLoading => _loadingNotifier.value;
  set isLoading(bool value) {
    _loadingNotifier.value = value;
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

      _suppliersService = SmartApiService<Suppliers>(
        fromJson: Suppliers.fromJson,
        toJson: (s) => s.toJson(),
        endPoint: ApiEndpoints.suppliers,
        baseUrl: StockTrackerApiUrl,
        header: {
          ...await _serviceAuthClient.getAuthHeaders(),
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      _isInitialized = true;
    } catch (e) {
      error.value = 'Servis başlatılamadı: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      isLoading = true;
      final data = await _suppliersService.getAll(priority: CachePriority.high);
      suppliers.value = data;
      if (data.isNotEmpty && selectedSupplier.value == null) {
        selectedSupplier.value = data.first;
      }
    } catch (e) {
      error.value = 'Veriler yüklenemedi: $e';
      suppliers.value = [];
      selectedSupplier.value = null;
    } finally {
      isLoading = false;
    }
  }

  Future<void> createSupplier(
    String name,
    String address,
    String identityNo,
    String phone,
    String email,
    int regionId,
  ) async {
    try {
      isLoading = true;
      final supplier = Suppliers.insert(
        name,
        address,
        identityNo,
        phone,
        email,
        regionId,
      );
      final created = await _suppliersService.create(supplier);
      await _loadData();
      selectedSupplier.value = created;
    } catch (e) {
      error.value = 'Tedarikçi oluşturulamadı: $e';
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateSupplier(
    int id,
    String name,
    int regionId,
    String address,
    String identityNo,
    String phone,
    String email,
  ) async {
    try {
      isLoading = true;
      final supplier = Suppliers.update(
        id,
        name,
        regionId,
        address,
        identityNo,
        phone,
        email,
      );
      await _suppliersService.updateById(id, supplier);
      await _loadData();
    } catch (e) {
      error.value = 'Tedarikçi güncellenemedi: $e';
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteSupplier(int id) async {
    try {
      isLoading = true;
      await _suppliersService.deleteById(id);
      if (selectedSupplier.value?.id == id) {
        selectedSupplier.value = null;
      }
      await _loadData();
    } catch (e) {
      error.value = 'Tedarikçi silinemedi: $e';
    } finally {
      isLoading = false;
    }
  }

  @override
  void dispose() {
    suppliers.dispose();
    selectedSupplier.dispose();
    _loadingNotifier.dispose();
    error.dispose();
    refreshTrigger.dispose();
    super.dispose();
  }
}
