part of warehouses;

class WarehousesEdit {
  final Warehouses warehouse;
  final BuildContext context;

  WarehousesEdit({
    required this.warehouse,
    required this.context,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: warehouse.description);
    final addressController = TextEditingController(text: warehouse.address);
    int? selectedRegionId = warehouse.regionId;
    int? selectedCityId = warehouse.cityId;

    final _authClient = ServiceAuthClient();
    final token = await _authClient.getAuthToken();

    final warehouseService = ServiceApiClient<Warehouses>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/warehouses',
      fromJson: (json) => Warehouses.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    final regionService = ServiceApiClient<Regions>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/regions',
      fromJson: (json) => Regions.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    final cityService = ServiceApiClient<Cities>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/1/cities',
      fromJson: (json) => Cities.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Depo Düzenle'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context
                      .myTextFormField(
                        labelText: 'Depo Adı',
                        controller: nameController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Depo adı gerekli' : null,
                      )
                      .paddingVertical(context.smallPadding),
                  context
                      .myTextFormField(
                        labelText: 'Adres',
                        controller: addressController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Adres gerekli' : null,
                      )
                      .paddingVertical(context.smallPadding),
                  FutureBuilder<List<Regions>>(
                    future: regionService.getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      final regions = snapshot.data ?? [];
                      return DropdownButtonFormField<int>(
                        value: selectedRegionId,
                        decoration: const InputDecoration(labelText: 'Bölge'),
                        items: regions.map((region) {
                          return DropdownMenuItem(
                            value: region.id,
                            child: Text(region.description),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedRegionId = value;
                          selectedCityId = null;
                        },
                        validator: (value) =>
                            value == null ? 'Bölge seçiniz' : null,
                      ).paddingVertical(context.smallPadding);
                    },
                  ),
                  if (selectedRegionId != null)
                    FutureBuilder<List<Cities>>(
                      future: cityService.getAll(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final cities = snapshot.data ?? [];
                        return DropdownButtonFormField<int>(
                          value: selectedCityId,
                          decoration: const InputDecoration(labelText: 'Şehir'),
                          items: cities.map((city) {
                            return DropdownMenuItem(
                              value: city.id,
                              child: Text(city.description),
                            );
                          }).toList(),
                          onChanged: (value) => selectedCityId = value,
                          validator: (value) =>
                              value == null ? 'Şehir seçiniz' : null,
                        ).paddingVertical(context.smallPadding);
                      },
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  final updatedWarehouse = Warehouses.insert(
                    nameController.text,
                    selectedRegionId ?? 0,
                    selectedCityId ?? 0,
                    addressController.text,
                  );
                  final response = await warehouseService.updateById(
                    warehouse.id!,
                    updatedWarehouse,
                  );
                  Navigator.pop(context, updatedWarehouse);
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }
}
