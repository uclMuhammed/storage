part of 'home_page.dart';

mixin HomePageMixin on State<HomePage> {
  bool changeAppBar = false;

  GenericApiService<Products> service =
      GenericApiService<Products>(endPoint: '/products', fromJson: Products.fromJson);

  String scanBarcode = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urunController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _miktarController = TextEditingController();

//Search işlemi
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

//-----------------------------------------------------------
  Future<void> scanBarcodeNormal() async {
    String barcodeScan;
    try {
      barcodeScan = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'cancel',
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      barcodeScan = 'ürün kodu okunmadı';
    }
    if (!mounted) return;
    setState(() {
      _barcodeController.text = barcodeScan;
    });
    if (_barcodeController.text.isNotEmpty) {
    } else if (barcodeScan == '-1') {
      _barcodeController.clear();
      return;
    } else {
      _urunEkleDialog();
    }
  }

  // Yeni ürün ekleme dialog'u göster
  void _urunEkleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yeni Ürün Ekle'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  keyboardType: TextInputType.name,
                  controller: _urunController,
                  text: "Ürün İsmi",
                  obscureText: false,
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  controller: _barcodeController,
                  text: "Ürün Barkodu",
                  obscureText: false,
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  controller: _miktarController,
                  text: "Stok Miktarı",
                  obscureText: false,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                _urunController.clear();
                _barcodeController.clear();
                _miktarController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Ekle'),
              onPressed: () {
                _urunEkle(service);
                _urunController.clear();
                _barcodeController.clear();
                _miktarController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Stok güncelleme dialog'u göster
  void _stokGuncelleDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                keyboardType: TextInputType.number,
                controller: _miktarController,
                text: 'Yeni Stok Miktar',
                obscureText: false,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                _urunController.clear();
                _barcodeController.clear();
                _miktarController.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Güncelle'),
              onPressed: () {
                _stokGuncelle(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Ürün silme onay dialog'u göster
  void _urunSilDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ürünü Sil'),
          actions: [
            TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Evet'),
              onPressed: () {
                _urunSil(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Yeni ürün ekleme fonksiyonu
  void _urunEkle(GenericApiService<Products> service) async {
    if (_formKey.currentState!.validate()) {
      try {
        final products = Products(
          id: 0,
          description: _urunController.text,
          barcode: _barcodeController.text,
          createdAt: DateTime.now(),
          createdBy: '',
          updatedAt: DateTime.now(),
          updatedBy: '',
          deletedAt: null,
          deletedBy: null,
          product: 0,
          categoryId: 0,
          companyId: 0,
          brandId: 0,
          unitId: 0,
          price: 200,
          dimensions: '',
          weight: 200,
          isActive: false,
          isDelete: false,
        );
        print('Sending data to the backend: ${products.toJson()}');
        if (products.barcode != '') {
          await service.create(products);
        } else {
          await service.update(products.id, products);
        }
      } catch (e) {}
    }
  }

  // Stok miktarını güncelle
  void _stokGuncelle(int index) {
    int yeniMiktar = int.tryParse(_miktarController.text) ?? 0;
    if (yeniMiktar > 0) {
      setState(() {});
      _urunController.clear();
      _barcodeController.clear();
      _miktarController.clear();
    }
  }

  // Ürün silme
  void _urunSil(int index) {
    setState(() {});
  }
}
