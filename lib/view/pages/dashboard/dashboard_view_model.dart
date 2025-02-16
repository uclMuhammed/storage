import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:backend/models/product_stats.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

enum TransactionType {
  all('Tümü'),
  purchase('Alış'),
  sale('Satış');

  final String label;
  const TransactionType(this.label);
}

class DashboardViewModel extends BaseViewModel {
  final pieChartKey = GlobalKey();

  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<ProductMovement> _productMovementService;
  late final SmartApiService<ProductStats> _productStatsService;
  bool _isInitialized = false;

  final productStats = ValueNotifier<List<ProductStats>>([]);
  final productMovements = ValueNotifier<List<ProductMovement>>([]);

  final selectedProductStats = ValueNotifier<ProductStats?>(null);
  final selectedProductMovement = ValueNotifier<ProductMovement?>(null);

  final error = ValueNotifier<String?>(null);
  final loadingNotifier = ValueNotifier<bool>(false);

  final touchedIndex = ValueNotifier<int?>(null);

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

      _productMovementService = SmartApiService<ProductMovement>(
        fromJson: ProductMovement.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.productMovements,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _productStatsService = SmartApiService<ProductStats>(
        fromJson: ProductStats.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.productStats,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      error.value = 'Servis başlatılamadı: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      setLoading(true);
      final productStatsData =
          await _productStatsService.getAll(priority: CachePriority.high);
      productStats.value = productStatsData;

      final productMovementsData =
          await _productMovementService.getAll(priority: CachePriority.high);
      productMovements.value = productMovementsData;

      if (productStatsData.isNotEmpty && selectedProductStats.value == null) {
        selectedProductStats.value = productStatsData.first;
      }

      if (productMovementsData.isNotEmpty &&
          selectedProductMovement.value == null) {
        selectedProductMovement.value = productMovementsData.first;
      }

      debugPrint('productStatsData: ${jsonEncode(productStatsData)}');
      debugPrint('productMovementsData: ${jsonEncode(productMovementsData)}');
    } catch (e) {
      error.value = 'Veriler yüklenirken hata oluştu: $e';
    } finally {
      setLoading(false);
    }
  }
}
