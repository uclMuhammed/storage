part of 'home_page.dart';

mixin HomePageMixin on State<HomePage> {
  final List<Urun> _urunler = [];
  String scanBarcode = '';
  final TextEditingController _urunController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _miktarController = TextEditingController();

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
    if (_urunler.any((e) => e.barkod == barcodeScan)) {
      _stokGuncelleDialog(
          _urunler.indexWhere((element) => element.barkod == barcodeScan));
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
          content: Column(
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
                _urunEkle();
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
    _miktarController.text =
        _urunler[index].miktar.toString(); // Mevcut miktarı göster
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${_urunler[index].isim} Stok Güncelle'),
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
          content: Text(
              '${_urunler[index].isim} adlı ürünü silmek istediğinize emin misiniz?'),
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
  void _urunEkle() {
    String urunIsmi = _urunController.text;
    String urunBarcode = _barcodeController.text;
    int urunMiktari = int.tryParse(_miktarController.text) ?? 0;

    if (urunIsmi.isNotEmpty && urunMiktari > 0) {
      setState(() {
        _urunler.add(Urun(
            isim: urunIsmi,
            miktar: urunMiktari,
            barkod: urunBarcode,
            uretimtarihi: DateTime(2001, 9, 27),
            sontuketimtarihi: DateTime(2024, 9, 27),
            partino: '9addc45'));
      });
      _urunController.clear();
      _barcodeController.clear();
      _miktarController.clear();
    }
  }

  // Stok miktarını güncelle
  void _stokGuncelle(int index) {
    int yeniMiktar = int.tryParse(_miktarController.text) ?? 0;
    if (yeniMiktar > 0) {
      setState(() {
        _urunler[index].miktar = yeniMiktar;
      });
      _urunController.clear();
      _barcodeController.clear();
      _miktarController.clear();
    }
  }

  // Ürün silme
  void _urunSil(int index) {
    setState(() {
      _urunler.removeAt(index);
    });
  }
}
