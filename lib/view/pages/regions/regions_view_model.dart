import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:widgets/base/base_view_model.dart';

class RegionsViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Regions> _regionsService;
  late final SmartApiService<Cities> _citiesService;
  bool _isInitialized = false;

  final regions = ValueNotifier<List<Regions>>([]);
  final cities = ValueNotifier<List<Cities>>([]);

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
      error.value = 'Hata oluştu: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      setLoading(true);
      final regionsData =
          await _regionsService.getAll(priority: CachePriority.high);
      regions.value = regionsData;
      final citiesData =
          await _citiesService.getAll(priority: CachePriority.high);
      cities.value = citiesData;
    } catch (e) {
      error.value = 'Veriler yüklenemedi: $e';
      regions.value = [];
      cities.value = [];
    } finally {
      setLoading(false);
    }
  }

  Future<void> createRegion(String description) async {
    try {
      setLoading(true);
      final region = Regions.insert(description);
      final created = await _regionsService.create(region);
      await _loadData();
      selectedRegion.value = regions.value.firstWhere(
        (r) => r.id == created.id,
        orElse: () => created,
      );
    } catch (e) {
      error.value = 'Bölge oluşturulamadı: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateRegion(int id, String description) async {
    try {
      setLoading(true);
      final region = Regions.update(id, description);
      await _regionsService.updateById(id, region);
      await _loadData();
      selectedRegion.value = regions.value.firstWhere(
        (r) => r.id == id,
        orElse: () => region,
      );
    } catch (e) {
      error.value = 'Bölge güncellenemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteRegion(int id) async {
    try {
      setLoading(true);
      await _regionsService.deleteById(id);
      await _loadData();
    } catch (e) {
      error.value = 'Bölge silinemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    regions.dispose();
    selectedRegion.dispose();
    loadingNotifier.dispose();
    error.dispose();
    cities.dispose();
    selectedCity.dispose();
    super.dispose();
  }
}
