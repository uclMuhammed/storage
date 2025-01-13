part of 'products_view.dart';

mixin ProductsViewModel<T extends ProductsView> on State<T> {
  final ProductServices pServices = ProductServices();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dimensionsController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  Products? selectedProduct;
  List<Products> products = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeServices();
    });
  }

  Future<void> _initializeServices() async {
    try {
      await pServices.init();
      await getAllProducts();
      setState(() {});
    } catch (e) {
      if (kDebugMode) print('Services initialization error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Servis başlatma hatası: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<Products>> getAllProducts() async {
    try {
      if (pServices.client == null) await pServices.init();
      products = await pServices.getAll();
      setState(() {});
      return products;
    } catch (e) {
      if (kDebugMode) print('GetAllProducts error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ürünler yüklenirken hata oluştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  Future<void> createProduct() async {
    try {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Yeni Ürün Ekle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: barcodeController,
                    decoration: const InputDecoration(labelText: 'Barkod'),
                  ),
                  TextField(
                    controller: codeController,
                    decoration: const InputDecoration(labelText: 'Kod'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Açıklama'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Fiyat'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: dimensionsController,
                    decoration: const InputDecoration(labelText: 'Boyutlar'),
                  ),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: 'Ağırlık'),
                    keyboardType: TextInputType.number,
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
                  if (_validateInputs()) {
                    try {
                      await pServices.create(
                        Products.insert(
                          barcodeController.text,
                          codeController.text,
                          descriptionController.text,
                          0, // brandId
                          0, // categoryId
                          0, // unitId
                          double.parse(priceController.text),
                          dimensionsController.text,
                          double.parse(weightController.text),
                        ),
                      );
                      _clearControllers();
                      Navigator.pop(context);
                      await getAllProducts();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ürün başarıyla eklendi'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hata: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Ekle'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) print('Create product error: $e');
    }
  }

  Future<void> editProduct(Products product) async {
    try {
      _setControllers(product);

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ürün Düzenle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: barcodeController,
                    decoration: const InputDecoration(labelText: 'Barkod'),
                  ),
                  TextField(
                    controller: codeController,
                    decoration: const InputDecoration(labelText: 'Kod'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Açıklama'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(labelText: 'Fiyat'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: dimensionsController,
                    decoration: const InputDecoration(labelText: 'Boyutlar'),
                  ),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: 'Ağırlık'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _clearControllers();
                  Navigator.pop(context);
                },
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () async {
                  if (_validateInputs()) {
                    try {
                      await pServices.update(
                        product.id,
                        Products.update(
                          barcodeController.text,
                          codeController.text,
                          descriptionController.text,
                          0, // brandId
                          0, // categoryId
                          0, // unitId
                          double.parse(priceController.text),
                          dimensionsController.text,
                          double.parse(weightController.text),
                        ),
                      );
                      _clearControllers();
                      Navigator.pop(context);
                      await getAllProducts();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ürün başarıyla güncellendi'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Hata: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Güncelle'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) print('Edit product error: $e');
    }
  }

  Future<void> deleteProduct(Products product) async {
    try {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ürün Sil'),
            content: Text(
                '${product.description} ürününü silmek istediğinize emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('İptal'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () async {
                  try {
                    await pServices.delete(product.id);
                    Navigator.pop(context);
                    await getAllProducts();
                    setState(() {
                      if (selectedProduct?.id == product.id) {
                        selectedProduct = null;
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ürün başarıyla silindi'),
                        backgroundColor: Colors.green,
                      ),
                    );
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
      if (kDebugMode) print('Delete product error: $e');
    }
  }

  void _setControllers(Products product) {
    barcodeController.text = product.barcode;
    codeController.text = product.code;
    descriptionController.text = product.description;
    priceController.text = product.price.toString();
    dimensionsController.text = product.dimensions;
    weightController.text = product.weight.toString();
  }

  void _clearControllers() {
    barcodeController.clear();
    codeController.clear();
    descriptionController.clear();
    priceController.clear();
    dimensionsController.clear();
    weightController.clear();
  }

  bool _validateInputs() {
    if (barcodeController.text.isEmpty ||
        codeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        dimensionsController.text.isEmpty ||
        weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurun!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    barcodeController.dispose();
    codeController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    dimensionsController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
