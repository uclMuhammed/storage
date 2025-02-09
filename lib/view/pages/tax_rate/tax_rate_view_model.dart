import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:widgets/base/base_view_model.dart';

class TaxRateViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<TaxRate> _taxRateService;
  bool _isInitialized = false;

  //value notifier
  final taxRates = ValueNotifier<List<TaxRate>>([]);
  final selectedTaxRate = ValueNotifier<TaxRate?>(null);
  final error = ValueNotifier<String?>(null);
  final refreshTrigger = ValueNotifier<bool>(false);
  final loadingNotifier = ValueNotifier<bool>(false);

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

      _taxRateService = SmartApiService<TaxRate>(
        fromJson: TaxRate.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.taxRates,
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
      final taxRatesData =
          await _taxRateService.getAll(priority: CachePriority.high);
      taxRates.value = taxRatesData;
      if (taxRatesData.isNotEmpty && selectedTaxRate.value == null) {
        selectedTaxRate.value = taxRatesData.first;
      }
    } catch (e) {
      error.value = 'Vergi oranı verisi yüklenemedi: $e';
      if (kDebugMode) {
        print('Vergi oranı verisi yüklenirken hata: $e');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> createTaxRate(
    String description,
    double tax,
  ) async {
    try {
      isLoading = true;
      final taxes = TaxRate.insert(tax, description);
      await _taxRateService.create(taxes);
      await _loadData();
    } catch (e) {
      error.value = 'Vergi oranı oluşturulamadı: $e';
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateTaxRate(
    int id,
    String description,
    double tax,
  ) async {
    try {
      isLoading = true;
      final taxes = TaxRate.update(id, tax, description);
      await _taxRateService.updateById(id, taxes);
      await _loadData();
    } catch (e) {
      error.value = 'Vergi oranı güncellenemedi: $e';
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteTaxRate(int id) async {
    try {
      isLoading = true;
      await _taxRateService.deleteById(id);
      await _loadData();
    } catch (e) {
      error.value = 'Vergi oranı silinemedi: $e';
      rethrow;
    } finally {
      isLoading = false;
    }
  }
}
