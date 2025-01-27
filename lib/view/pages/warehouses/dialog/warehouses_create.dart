part of warehouses;

class WarehousesCreate {
  final BuildContext context;

  WarehousesCreate({
    required this.context,
  });

  Future<bool?> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    int? selectedRegionId;
    int? selectedCityId;

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

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Depo'),
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
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  try {
                    final newWarehouse = Warehouses.insert(
                      nameController.text,
                      selectedRegionId ?? 0,
                      selectedCityId ?? 31,
                      addressController.text,
                    );
                    await warehouseService.create(newWarehouse);
                    Navigator.pop(context, true);
                  } catch (e) {
                    Navigator.pop(context, false);
                  }
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
