part of 'brands.dart';

mixin BrandsMixin<T extends StatefulWidget> on State<T> {
  GenericApiService<Brands>? _brandsService;
  Future<List<Brands>>? _brandsFuture;

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    _brandsService = await ServiceManager().getService<GenericApiService<Brands>>(runtimeType);
    _refreshBrands();
  }

  void _refreshBrands() {
    if (_brandsService != null) {
      setState(() {
        _brandsFuture = _brandsService!.getAll();
      });
    }
  }

  Future<void> deleteBrand(
      BuildContext context, GenericApiService<Brands> brandsService, Brands brand) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${brand.description} silinsin mi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              await brandsService.delete(brand.id);
              if (mounted) {
                Navigator.pop(context);
                _refreshBrands();
              }
              ;
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  Future<void> showBrandDialog(BuildContext context, GenericApiService<Brands> brandsService,
      {Brands? brand}) async {
    final TextEditingController descriptionController =
        TextEditingController(text: brand?.description);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(brand == null ? 'Yeni Marka Ekle' : 'Markayı Düzenle'),
        content: TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Marka Adı',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              if (descriptionController.text.isNotEmpty) {
                if (brand == null) {
                  await _createBrand(context, brandsService,
                      description: descriptionController.text);
                } else {
                  await _updateBrand(
                    context,
                    brandsService,
                    Brands(
                      brand: brand.brand,
                      description: descriptionController.text,
                      companyId: brand.companyId,
                      id: brand.id,
                      isActive: brand.isActive,
                      isDelete: brand.isDelete,
                      createdAt: brand.createdAt,
                      createdBy: brand.createdBy,
                      updatedAt: DateTime.now(),
                      updatedBy: '',
                      deletedAt: brand.deletedAt,
                      deletedBy: brand.deletedBy,
                    ),
                  );
                }
                if (mounted) {
                  Navigator.pop(context);
                  _refreshBrands();
                }
              }
            },
            child: Text(brand == null ? 'Ekle' : 'Güncelle'),
          ),
        ],
      ),
    );
  }

  Future<void> _createBrand(BuildContext context, GenericApiService<Brands> brandsService,
      {required String description}) async {
    try {
      final newBrand = Brands(
        brand: 0,
        companyId: 1,
        description: description,
        id: 0,
        isActive: true,
        isDelete: false,
        createdAt: DateTime.now(),
        createdBy: '',
        updatedAt: null,
        updatedBy: null,
        deletedBy: null,
        deletedAt: null,
      );

      await brandsService.create(newBrand);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marka başarıyla eklendi')),
        );
        _refreshBrands();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }

  Future<void> _updateBrand(
      BuildContext context, GenericApiService<Brands> brandsService, Brands brand) async {
    try {
      await brandsService.update(brand.id, brand);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marka başarıyla güncellendi')),
        );
        _refreshBrands();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }
}
