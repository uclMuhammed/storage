part of 'products.dart';

mixin ProductsMixin<T extends StatefulWidget> on State<T> {
  final _formKey = GlobalKey<FormState>();
  final _productController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _companyIdController = TextEditingController();
  final _unitController = TextEditingController();
  final _priceController = TextEditingController();
  final _dimensionController = TextEditingController();
  final _weightController = TextEditingController();
  final _categoryController = TextEditingController();
  final _brandController = TextEditingController();

  Future<void> showProductDialog(
    BuildContext context,
    ServiceResponse<Products> productsService,
    ServiceResponse<Brands> brandsService,
    ServiceResponse<ProductUnits> unitsService,
    ServiceResponse<Categories> categoriesService, {
    required List<Categories> categories,
    required List<ProductUnits> units,
    required List<Brands> brands,
    Products? product,
  }) async {
    if (product != null) {
      _productController.text = product.description;
      _barcodeController.text = product.barcode;
      _companyIdController.text = product.companyId.toString();
      _unitController.text = product.unitId.toString();
      _priceController.text = product.price.toString();
      _dimensionController.text = product.dimensions;
      _weightController.text = product.weight.toString();
      _categoryController.text = product.categoryId.toString();
      _brandController.text = product.brandId.toString();
    }

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: AlertDialog(
            title: Text(product == null ? 'Yeni Ürün Ekle' : 'Ürünü Düzenle'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: _productController,
                    text: 'Ürün Adı',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ürün adı boş olamaz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _barcodeController,
                    text: 'Ürün Kodu',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ürün kodu boş olamaz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _companyIdController,
                    text: 'Şirket Kodu',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şirket kodu boş olamaz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  // Kategori Seçimi/Ekleme
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          hint: const Text('Kategori'),
                          value: int.tryParse(_categoryController.text),
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Kategori seçiniz';
                            }
                            return null;
                          },
                          items: categories.map((category) {
                            return DropdownMenuItem<int>(
                              value: category.id,
                              child: Text(category.description),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _categoryController.text = value.toString();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () => _showAddCategoryDialog(context, categoriesService, null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Marka Seçimi/Ekleme
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          hint: const Text('Marka'),
                          value: int.tryParse(_brandController.text),
                          decoration: const InputDecoration(
                            labelText: 'Marka',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Marka seçiniz';
                            }
                            return null;
                          },
                          items: brands.map((brand) {
                            return DropdownMenuItem<int>(
                              value: brand.id,
                              child: Text(brand.description),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _brandController.text = value.toString();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () => _showAddBrandDialog(context, brandsService, null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Birim Seçimi/Ekleme
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          hint: const Text('Birim'),
                          value: int.tryParse(_unitController.text),
                          decoration: const InputDecoration(
                            labelText: 'Birim',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Birim seçiniz';
                            }
                            return null;
                          },
                          items: units.map((unit) {
                            return DropdownMenuItem<int>(
                              value: unit.id,
                              child: Text(unit.description),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _unitController.text = value.toString();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () => _showAddUnitDialog(context, unitsService, null),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _priceController,
                    text: 'Fiyat',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fiyat boş olamaz';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Geçerli bir fiyat giriniz';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _dimensionController,
                    text: 'Boyut',
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _weightController,
                    text: 'Kilo',
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (double.tryParse(value) == null) {
                          return 'Geçerli bir ağırlık giriniz';
                        }
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _resetForm();
                  Navigator.pop(context);
                },
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: () => _handleSubmit(context, productsService, product),
                child: Text(product == null ? 'Ekle' : 'Güncelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(
    BuildContext context,
    ServiceResponse<Products> productsService,
    Products? product,
  ) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final productData = Products(
          id: product?.id ?? 0,
          description: _productController.text.trim(),
          barcode: _barcodeController.text.trim(),
          createdAt: product?.createdAt ?? DateTime.now(),
          createdBy: product?.createdBy ?? '',
          updatedAt: DateTime.now(),
          updatedBy: product?.updatedBy ?? '',
          deletedAt: product?.deletedAt,
          deletedBy: product?.deletedBy,
          product: product?.product ?? 0,
          categoryId: int.parse(_categoryController.text),
          companyId: int.parse(_companyIdController.text),
          brandId: int.parse(_brandController.text),
          unitId: int.parse(_unitController.text),
          price: int.parse(_priceController.text),
          dimensions: _dimensionController.text.trim(),
          weight: double.tryParse(_weightController.text) ?? 0.0,
          isActive: true,
          isDelete: false,
        );

        if (product == null) {
          await createProduct(context, productsService, product: productData);
        } else {
          await updateProduct(context, productsService, productData);
        }

        if (mounted) {
          _resetForm();
          Navigator.of(context).pop();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> createProduct(
    BuildContext context,
    ServiceResponse<Products> productsService, {
    required Products product,
  }) async {
    try {
      await productsService.service.create(product);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ürün başarıyla oluşturuldu'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(
    BuildContext context,
    ServiceResponse<Products> productsService,
    Products product,
  ) async {
    try {
      await productsService.service.update(product.id, product);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ürün başarıyla güncellendi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _showAddCategoryDialog(
    BuildContext context,
    ServiceResponse<Categories> categoriesService,
    Categories? categories,
  ) async {
    final categoryNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Yeni Kategori Ekle'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: categoryNameController,
                  text: 'Kategori Adı',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kategori adı boş olamaz';
                    }
                    return null;
                  },
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (formKey.currentState?.validate() ?? false) {
                        setState(() => isLoading = true);

                        try {
                          final newCategory = Categories(
                            description: categoryNameController.text.trim(),
                            category: categories?.category ?? 0,
                            companyId: categories?.companyId ?? 0,
                            id: categories?.id ?? 0,
                            isActive: categories?.isActive ?? true,
                            isDelete: categories?.isDelete ?? false,
                            createdAt: categories?.createdAt ?? DateTime.now(),
                            createdBy: categories?.createdBy ?? '',
                            updatedAt: categories?.updatedAt ?? DateTime.now(),
                            updatedBy: categories?.updatedBy ?? '',
                            deletedBy: categories?.deletedBy,
                            deletedAt: categories?.deletedAt,
                          );

                          await categoriesService.service.create(newCategory);

                          if (mounted) {
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Kategori başarıyla eklendi'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() => isLoading = false);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString().replaceAll('Exception: ', '')),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      }
                    },
              child: Text(isLoading ? 'Ekleniyor...' : 'Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddBrandDialog(
      BuildContext context, ServiceResponse<Brands> brandsService, Brands? brands) async {
    final brandNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Yeni Marka Ekle'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: brandNameController,
                  text: 'Marka Adı',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Marka adı boş olamaz';
                    }
                    return null;
                  },
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (formKey.currentState?.validate() ?? false) {
                        setState(() => isLoading = true);

                        try {
                          final newBrand = Brands(
                            brand: brands?.brand ?? 0,
                            description: brandNameController.text.trim(),
                            companyId: brands?.companyId ?? 0,
                            id: brands?.id ?? 0,
                            isActive: true,
                            isDelete: false,
                            createdAt: DateTime.now(),
                            createdBy: '',
                            updatedAt: null,
                            updatedBy: null,
                            deletedBy: null,
                            deletedAt: null,
                          );

                          await brandsService.service.create(newBrand);

                          if (mounted) {
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Marka başarıyla eklendi'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() => isLoading = false);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString().replaceAll('Exception: ', '')),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      }
                    },
              child: Text(isLoading ? 'Ekleniyor...' : 'Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddUnitDialog(
    BuildContext context,
    ServiceResponse<ProductUnits> productUnitsService,
    ProductUnits? unit,
  ) async {
    final unitNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Yeni Birim Ekle'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  controller: unitNameController,
                  text: 'Birim Adı',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Birim adı boş olamaz';
                    }
                    return null;
                  },
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (formKey.currentState?.validate() ?? false) {
                        setState(() => isLoading = true);

                        try {
                          // final newUnit = ProductUnits(
                          //   unit: unit?.unit ?? 0,
                          //   description: unitNameController.text.trim(),
                          //   quantity: unit?.quantity ?? 1.0,
                          //   companyid: unit?.companyid ?? 0,
                          //   id: unit?.id ?? 0,
                          //   isActive: unit?.isActive ?? false,
                          //   isDelete: unit?.isDelete ?? false,
                          //   createdAt: unit?.createdAt ?? DateTime.now(),
                          //   createdBy: unit?.createdBy ?? '',
                          //   updatedAt: unit?.updatedAt ?? DateTime.now(),
                          //   updatedBy: unit?.updatedBy ?? '',
                          //   deletedBy: unit?.deletedBy ?? "",
                          //   deletedAt: unit?.deletedAt ?? DateTime.now(),
                          // );

                          // if (kDebugMode) {
                          //   print('Sending unit data: ${newUnit.toJson()}');
                          // }

                          await productUnitsService.service
                              .create(ProductUnits.insert(unitNameController.text.trim(), 10));

                          if (mounted) {
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Birim başarıyla eklendi'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() => isLoading = false);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString().replaceAll('Exception: ', '')),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      }
                    },
              child: Text(isLoading ? 'Ekleniyor...' : 'Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _productController.clear();
    _barcodeController.clear();
    _companyIdController.clear();
    _categoryController.clear();
    _brandController.clear();
    _unitController.clear();
    _priceController.clear();
    _dimensionController.clear();
    _weightController.clear();
  }

  @override
  void dispose() {
    _productController.dispose();
    _barcodeController.dispose();
    _companyIdController.dispose();
    _categoryController.dispose();
    _brandController.dispose();
    _unitController.dispose();
    _priceController.dispose();
    _dimensionController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
