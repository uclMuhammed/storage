part of 'warehouses_view.dart';

mixin WarehousesViewModel<T extends WarehousesView> on State<T> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final RegionsServices rServices = RegionsServices();
  final WarehousesServices wServices = WarehousesServices();
  final CitiesService cServices = CitiesService();
  Warehouses? selectedWarehouse;
  Regions? selectedRegion;
  Cities? selectedCity;
  final List<Warehouses> warehouses = [];
  final List<Regions> regions = [];
  final List<Cities> cities = [];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      await Future.wait([
        rServices.init(),
        cServices.init(),
        wServices.init(),
      ]);
      _isInitialized = true;
      if (mounted) setState(() {});
    } catch (e) {
      if (kDebugMode) print('Services initialization error: $e');
    }
  }

  Future<List<Warehouses>> getAllWarehouses() async {
    if (!_isInitialized) {
      await _initializeServices();
    }

    try {
      final warehouses = await wServices.getAll();
      return warehouses;
    } catch (e) {
      if (kDebugMode) print('GetAllWarehouses error: $e');
      rethrow;
    }
  }

  Future<List<Regions>> getAllRegions() async {
    final regions = await rServices.getAll();
    return regions;
  }

  Future<List<Cities>> getAllCities() async {
    final cities = await cServices.getAll();
    return cities;
  }

  Future<Warehouses> getWarehouseById(int id) async {
    final warehouse = await wServices.getById(id);
    selectedWarehouse = warehouse;
    return warehouse;
  }

  Future<Regions> getRegionsById(int id) async {
    final regions = await rServices.getById(id);
    return selectedRegion = regions;
  }

  Future<Cities> getCitiesById(int id) async {
    final cities = await cServices.getById(id);
    return selectedCity = cities;
  }

  Future<void> createWarehouse() async {
    // Default olarak 1 ID'li country'ı seç
    cServices.setCountryId(1);

    try {
      // Regions ve Cities listelerini doldur
      regions.clear(); // Önceki verileri temizle
      cities.clear();

      regions.addAll(await getAllRegions());
      cities.addAll(await getAllCities());

      // Seçili değerleri sıfırla
      selectedRegion = null;
      selectedCity = null;

      await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            // StatefulBuilder ekledik
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Yeni Depo Ekleme'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Depo Adı'),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Regions>(
                      value: selectedRegion,
                      hint: Text('Bölge Seçin'),
                      isExpanded: true,
                      items: regions.map((region) {
                        return DropdownMenuItem<Regions>(
                          value: region,
                          child: Text(region.description),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRegion = value;
                          selectedCity = null; // Bölge değişince şehri sıfırla
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Cities>(
                      value: selectedCity,
                      hint: Text('Şehir Seçin'),
                      isExpanded: true,
                      items: cities.map(
                        (city) {
                          return DropdownMenuItem<Cities>(
                            value: city,
                            child: Text(city.description),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Adres'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Dialog'u kapatırken değerleri temizle
                      nameController.clear();
                      addressController.clear();
                      selectedRegion = null;
                      selectedCity = null;
                      Navigator.pop(context);
                    },
                    child: const Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          selectedRegion != null &&
                          selectedCity != null) {
                        try {
                          await wServices.create(Warehouses.insert(
                            nameController.text,
                            selectedRegion!.id,
                            selectedCity!.id,
                            addressController.text,
                          ));

                          // Dialog'u kapat ve değerleri temizle
                          nameController.clear();
                          addressController.clear();
                          selectedRegion = null;
                          selectedCity = null;
                          Navigator.pop(context);

                          // Başarılı mesajı göster
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Depo başarıyla eklendi'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // Listeyi yenile
                          setState(() {});
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Hata: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Lütfen tüm alanları doldurun!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text('Ekle'),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      if (kDebugMode) print('Create warehouse error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> editWarehouse(Warehouses warehouse) async {
    try {
      cServices.setCountryId(1);

      // Form kontrollerini mevcut değerlerle doldur
      nameController.text = warehouse.description;
      addressController.text = warehouse.address;

      // Önce seçili değerleri temizle
      selectedRegion = null;
      selectedCity = null;

      // Listeleri temizle
      regions.clear();
      cities.clear();

      // Önce listeleri doldur
      regions.addAll(await getAllRegions());
      cities.addAll(await getAllCities());

      // Sonra seçili değerleri ayarla
      try {
        // Mevcut bölge ve şehri bul
        selectedRegion = regions.firstWhere((r) => r.id == warehouse.regionId);
        selectedCity = cities.firstWhere((c) => c.id == warehouse.cityId);
      } catch (e) {
        print('Bölge/Şehir bilgileri alınamadı: $e');
      }

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: const Text('Depo Düzenle'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(labelText: 'Depo Adı'),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Regions>(
                        value: selectedRegion,
                        hint: const Text('Bölge Seçin'),
                        isExpanded: true,
                        items: regions
                            .map((region) => DropdownMenuItem<Regions>(
                                  key: ValueKey(region.id),
                                  value: region,
                                  child: Text(region.description),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedRegion = value;
                            selectedCity =
                                null; // Bölge değişince şehri sıfırla
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Cities>(
                        value: selectedCity,
                        hint: const Text('Şehir Seçin'),
                        isExpanded: true,
                        items: cities
                            .map((city) => DropdownMenuItem<Cities>(
                                  key: ValueKey(city.id),
                                  value: city,
                                  child: Text(city.description),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedCity = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: addressController,
                        decoration: const InputDecoration(labelText: 'Adres'),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          selectedRegion != null &&
                          selectedCity != null) {
                        try {
                          await wServices.update(
                            warehouse.id,
                            Warehouses.insert(
                              nameController.text,
                              selectedRegion!.id,
                              selectedCity!.id,
                              addressController.text,
                            ),
                          );

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Depo başarıyla güncellendi'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {});
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Hata: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Lütfen tüm alanları doldurun!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text('Güncelle'),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      if (kDebugMode) print('Edit warehouse error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteWarehouse(Warehouses warehouse) async {
    try {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Depo Sil'),
            content: Text(
                '${warehouse.description} deposunu silmek istediğinize emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('İptal'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () async {
                  try {
                    await wServices.delete(warehouse.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Depo başarıyla silindi'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {
                      if (selectedWarehouse?.id == warehouse.id) {
                        selectedWarehouse = null;
                        selectedRegion = null;
                        selectedCity = null;
                      }
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Hata: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Sil'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) print('Delete warehouse error: $e');
    }
  }

  @override
  void dispose() {
    rServices.dispose();
    cServices.dispose();
    wServices.dispose();
    super.dispose();
  }
}
