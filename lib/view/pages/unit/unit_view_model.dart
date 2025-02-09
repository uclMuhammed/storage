import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class UnitViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<ProductUnits> _unitsService;
  bool _isInitialized = false;

  final units = ValueNotifier<List<ProductUnits>>([]);
  final selectedUnit = ValueNotifier<ProductUnits?>(null);

  final loadingNotifier = ValueNotifier<bool>(false);
  final error = ValueNotifier<String?>(null);

  @override
  bool get isLoading => loadingNotifier.value;

  @override
  void setLoading(bool value) {
    loadingNotifier.value = value;
    if (value) error.value = null;
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

      _unitsService = SmartApiService<ProductUnits>(
        fromJson: ProductUnits.fromJson,
        toJson: (u) => u.toJson(),
        endPoint: '/productUnits',
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
      final data = await _unitsService.getAll(priority: CachePriority.high);
      units.value = data;
      if (data.isNotEmpty && selectedUnit.value == null) {
        selectedUnit.value = data.first;
      }
    } catch (e) {
      error.value = 'Veriler yüklenemedi: $e';
      units.value = [];
      selectedUnit.value = null;
    } finally {
      setLoading(false);
    }
  }

  Future<void> createUnit(String name, double quantity) async {
    try {
      setLoading(true);
      final unit = ProductUnits.insert(name, quantity);
      final created = await _unitsService.create(unit);
      await _loadData();
      selectedUnit.value = units.value.firstWhere(
        (u) => u.id == created.id,
        orElse: () => created,
      );
    } catch (e) {
      error.value = 'Birim oluşturulamadı: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateUnit(String name, double quantity, bool? isActive) async {
    try {
      setLoading(true);
      final unit = ProductUnits.update(name, quantity, isActive);
      await _unitsService.updateById(selectedUnit.value!.id!, unit);
      await _loadData();
      selectedUnit.value = units.value.firstWhere(
        (u) => u.id == unit.id,
        orElse: () => unit,
      );
    } catch (e) {
      error.value = 'Birim güncellenemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteUnit(int id) async {
    try {
      setLoading(true);
      await _unitsService.deleteById(id);
      if (selectedUnit.value?.id == id) {
        selectedUnit.value = units.value.first;
      }
      await _loadData();
    } catch (e) {
      error.value = 'Birim silinemedi: $e';
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    units.dispose();
    selectedUnit.dispose();
    loadingNotifier.dispose();
    error.dispose();
    super.dispose();
  }
}
