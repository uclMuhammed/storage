part of '../warehouses_view.dart';

class WarehousesEdit {
  final Warehouses warehouse;
  final BuildContext context;
  final WarehousesViewModel viewModel;

  WarehousesEdit({
    required this.warehouse,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: warehouse.description);
    final addressController = TextEditingController(text: warehouse.address);
    int? selectedRegionId = warehouse.regionId;
    int? selectedCityId = warehouse.cityId;

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
                  ValueListenableBuilder<List<Regions>>(
                    valueListenable: viewModel.regions,
                    builder: (context, regions, _) {
                      final uniqueRegions = regions
                          .where((region) => region.isDelete != true)
                          .toSet()
                          .toList();

                      if (selectedRegionId != null &&
                          !uniqueRegions
                              .any((region) => region.id == selectedRegionId)) {
                        selectedRegionId = null;
                      }

                      return context
                          .myDropdownButtonFormField<int>(
                            labelText: 'Bölge',
                            value: selectedRegionId,
                            style: context.smallTextStyle,
                            items: uniqueRegions.map((region) {
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
                          )
                          .paddingVertical(context.smallPadding);
                    },
                  ),
                  ValueListenableBuilder<List<Cities>>(
                    valueListenable: viewModel.cities,
                    builder: (context, cities, _) {
                      final uniqueCities = cities
                          .where((city) => city.isDelete != true)
                          .toSet()
                          .toList();

                      if (selectedCityId != null &&
                          !uniqueCities
                              .any((city) => city.id == selectedCityId)) {
                        selectedCityId = null;
                      }

                      return context
                          .myDropdownButtonFormField<int>(
                            labelText: 'Şehir',
                            value: selectedCityId,
                            style: context.smallTextStyle,
                            items: uniqueCities.map((city) {
                              return DropdownMenuItem(
                                value: city.id,
                                child: Text(city.description),
                              );
                            }).toList(),
                            onChanged: (value) => selectedCityId = value,
                            validator: (value) =>
                                value == null ? 'Şehir seçiniz' : null,
                          )
                          .paddingVertical(context.smallPadding);
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
                  try {
                    await viewModel.updateWarehouse(
                      nameController.text,
                      selectedRegionId ?? 0,
                      selectedCityId ?? 31,
                      addressController.text,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
                    // Hata durumunda dialog'u kapatma
                    if (kDebugMode) {
                      print('Güncelleme hatası: $e');
                    }
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
