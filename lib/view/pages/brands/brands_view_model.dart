import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class BrandsViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Brands> _brandsService;
  bool _isInitialized = false;

  final brands = ValueNotifier<List<Brands>>([]);
  final selectedBrand = ValueNotifier<Brands?>(null);

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

      _brandsService = SmartApiService<Brands>(
        fromJson: Brands.fromJson,
        toJson: (b) => b.toJson(),
        endPoint: ApiEndpoints.brands,
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
      final data = await _brandsService.getAll(priority: CachePriority.high);
      brands.value = data;

      if (data.isNotEmpty && selectedBrand.value == null) {
        selectedBrand.value = data.first;
      }
    } catch (e) {
      error.value = 'Veriler yüklenemedi: $e';
      brands.value = [];
      selectedBrand.value = null;
    } finally {
      setLoading(false);
    }
  }

  Future<void> createBrand(String name) async {
    try {
      setLoading(true);
      final brand = Brands.insert(name);
      final created = await _brandsService.create(brand);
      await _loadData();
      selectedBrand.value = brands.value.firstWhere(
        (b) => b.id == created.id,
        orElse: () => created,
      );
    } catch (e) {
      error.value = 'Marka oluşturulamadı: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateBrand(String name) async {
    try {
      setLoading(true);
      final brand = Brands.insert(name);
      await _brandsService.updateById(brand.id, brand);
      await _loadData();
      selectedBrand.value = brands.value.firstWhere(
        (b) => b.id == brand.id,
        orElse: () => brand,
      );
    } catch (e) {
      error.value = 'Marka güncellenemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteBrand(int id) async {
    try {
      setLoading(true);
      await _brandsService.deleteById(id);
      await _loadData();
    } catch (e) {
      error.value = 'Marka silinemedi: $e';
    } finally {
      setLoading(false);
    }
  }
}
