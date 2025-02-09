import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:widgets/base/base_view_model.dart';

class ReferenceViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<ReferenceCode> _referenceService;
  bool _isInitialized = false;

  //value notifier
  final references = ValueNotifier<List<ReferenceCode>>([]);

  final selectedReference = ValueNotifier<ReferenceCode?>(null);

  final error = ValueNotifier<String?>(null);
  final loadingNotifier = ValueNotifier<bool>(false);

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

      _referenceService = SmartApiService<ReferenceCode>(
        fromJson: ReferenceCode.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.references,
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
      setLoading(true);
      final referencesData =
          await _referenceService.getAll(priority: CachePriority.high);

      references.value = referencesData;
      if (referencesData.isNotEmpty && selectedReference.value == null) {
        selectedReference.value = referencesData.first;
      }
    } catch (e) {
      error.value = 'Referans verisi yüklenemedi: $e';
      if (kDebugMode) {
        print('Referans verisi yüklenirken hata: $e');
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> createReference(
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      setLoading(true);

      final reference = ReferenceCode.insert(
        description,
        startDate,
        endDate,
      );

      await _referenceService.create(reference);
      await _loadData();
      selectedReference.value = references.value.firstWhere(
        (p) => p.id == reference.id,
        orElse: () => reference,
      );
    } catch (e) {
      error.value = 'Referans oluşturulamadı: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateReference(int id, String description) async {
    try {
      setLoading(true);
      final reference = ReferenceCode.update(id, description);
      await _referenceService.updateById(id, reference);
      await _loadData();
      if (selectedReference.value != null) {
        selectedReference.value = references.value.firstWhere(
          (p) => p.id == selectedReference.value!.id,
          orElse: () => ReferenceCode.empty(),
        );
      }
    } catch (e) {
      error.value = 'Referans güncellenemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteReference(int id) async {
    try {
      setLoading(true);
      await _referenceService.deleteById(id);
      await _loadData();
      if (selectedReference.value != null) {
        selectedReference.value = references.value.firstWhere(
          (p) => p.id == selectedReference.value!.id,
          orElse: () => ReferenceCode.empty(),
        );
      }
    } catch (e) {
      error.value = 'Referans silinemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    references.dispose();
    selectedReference.dispose();
    error.dispose();
    loadingNotifier.dispose();
    super.dispose();
  }
}
