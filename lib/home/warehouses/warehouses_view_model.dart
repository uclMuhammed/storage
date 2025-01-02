part of 'warehouses_view.dart';

mixin WarehousesViewModel<T extends WarehousesView> on State<T> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final RegionsServices rServices = RegionsServices();
  final WarehousesServices wServices = WarehousesServices();
  final CitiesService cServices = CitiesService();
  final List<Regions> regions = [];
  final List<Cities> cities = [];
  @override
  void initState() {
    rServices.init();
    cServices.init();
    wServices.init();
    super.initState();
  }

  Future<List<Regions>> getAllRegions() async {
    final regions = await rServices.getAll();
    return regions;
  }

  Future<List<Cities>> getAllCities() async {
    final cities = await cServices.getAll();
    return cities;
  }

  Future<void> createWarehouse() async {
    // Default olarak 1 ID'li country'ı seç
    cServices.setCountryId(1);

    // Regions ve Cities listelerini doldur
    regions.addAll(await getAllRegions());
    cities.addAll(await getAllCities());

    // Seçilen bölge ve şehir için değişkenler
    Regions? selectedRegion;
    Cities? selectedCity;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Depo Ekleme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Depo Adı'),
              ),
              DropdownButtonFormField<Regions>(
                value: selectedRegion,
                items: regions
                    .map((region) => DropdownMenuItem<Regions>(
                          value: region,
                          child: Text(region.description),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Bölge Seçin'),
                onChanged: (value) {
                  setState(() {
                    selectedRegion = value;
                  });
                },
              ),
              DropdownButtonFormField<Cities>(
                value: selectedCity,
                items: cities
                    .map((city) => DropdownMenuItem<Cities>(
                          value: city,
                          child: Text(city.description),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Şehir Seçin'),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Adres'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                // Tüm alanların dolu olup olmadığını kontrol et
                if (nameController.text.isNotEmpty &&
                    addressController.text.isNotEmpty &&
                    selectedRegion != null &&
                    selectedCity != null) {
                  // Warehouses.insert metoduna tüm gerekli parametreleri ekle
                  await wServices.create(Warehouses.insert(
                    nameController.text,
                    selectedRegion!.id,
                    selectedCity!.id,
                    addressController.text,
                  ));

                  // Dialog ve controller'ları temizle
                  nameController.clear();
                  addressController.clear();
                  selectedRegion = null;
                  selectedCity = null;
                  Navigator.pop(context);
                } else {
                  // Eksik alan varsa uyarı göster
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
  }

  @override
  void dispose() {
    rServices.dispose();
    cServices.dispose();
    wServices.dispose();
    super.dispose();
  }
}
