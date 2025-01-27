import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';

class RegionsViewModel extends BaseViewModel {
  //key
  final Key key = Key('_regions_view_key');

  // Service Auth Client
  final _authClient = ServiceAuthClient();

  // Service
  ServiceApiClient? serviceApiClient;

  // ValueNotifier
  final ValueNotifier<List<Regions>> regions = ValueNotifier([]);

  final ValueNotifier<Regions?> selectedRegion = ValueNotifier(null);
  final ValueNotifier<bool> refreshTrigger = ValueNotifier(false);

  @override
  void init() {
    _authClient.init();
    _initServiceApiClient();
  }

  @override
  void dispose() {
    serviceApiClient?.dispose();
    super.dispose();
  }

  Future<void> _initServiceApiClient() async {
    final token = await _authClient.getAuthToken();
    serviceApiClient = ServiceApiClient<Regions>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/regions',
      fromJson: (json) => Regions.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();
  }

  Future<List<IModel>> getAllRegions() async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }
      final response = await serviceApiClient!.getAll();
      regions.value = response.map((e) => e as Regions).toList();

      if (selectedRegion.value == null && response.isNotEmpty) {
        selectedRegion.value = response.first as Regions;
      }

      return response;
    } catch (e) {
      print('Bölge yükleme hatası: $e');
      return [];
    }
  }

  Future<bool> deleteRegion(int regionId) async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }
      final response = await serviceApiClient!.deleteById(regionId);
      if (response) {
        final updatedList = await getAllRegions();
        regions.value = updatedList.map((e) => e as Regions).toList();
        return true;
      }
      return false;
    } catch (e) {
      print('Bölge silme hatası: $e');
      return false;
    }
  }

  Future<bool> updateRegion(Regions region) async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }
      final response =
          await serviceApiClient!.updateById(region.region, region);
      if (response == true) {
        final updatedList = await getAllRegions();
        regions.value = updatedList.map((e) => e as Regions).toList();

        if (selectedRegion.value?.id == region.id) {
          selectedRegion.value = region;
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Bölge güncelleme hatası: $e');
      return false;
    }
  }

  Future<bool> createRegion(Regions region) async {
    try {
      if (serviceApiClient == null) {
        await _initServiceApiClient();
      }
      final response = await serviceApiClient!.create(region);
      if (response == true) {
        final updatedList = await getAllRegions();
        regions.value = updatedList.map((e) => e as Regions).toList();
        return true;
      }
      return false;
    } catch (e) {
      print('Bölge oluşturma hatası: $e');
      return false;
    }
  }

  void refresh() {
    refreshTrigger.value = !refreshTrigger.value;
  }
}
