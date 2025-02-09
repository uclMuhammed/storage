part of '../product_view.dart';

class ProductEdit {
  final Products product;
  final BuildContext context;
  final ProductViewModel viewModel;

  ProductEdit({
    required this.product,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final barcodeController = TextEditingController(text: product.barcode);
    final codeController = TextEditingController(text: product.code);
    final descriptionController =
        TextEditingController(text: product.description);
    final priceController =
        TextEditingController(text: product.price.toString());
    final dimensionsController =
        TextEditingController(text: product.dimensions);
    final weightController =
        TextEditingController(text: product.weight.toString());
    int? selectedBrandId = product.brandId;
    int? selectedCategoryId = product.categoryId;
    int? selectedCategorySubId = product.categorySubId;
    int? selectedUnitId = product.unitId;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ürün Düzenle'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.myTextFormField(
                    labelText: 'Açıklama',
                    hintText: '',
                    controller: descriptionController,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Açıklama gerekli' : null,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: const Divider(),
                  ).paddingVertical(context.smallPadding / 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            context
                                .myTextFormField(
                                  labelText: 'Barkod',
                                  controller: barcodeController,
                                  validator: (value) => value?.isEmpty == true
                                      ? 'Barkod gerekli'
                                      : null,
                                )
                                .paddingBottom(context.smallPadding),
                            context
                                .myTextFormField(
                                  labelText: 'Kod',
                                  controller: codeController,
                                  validator: (value) => value?.isEmpty == true
                                      ? 'Kod gerekli'
                                      : null,
                                )
                                .paddingBottom(context.smallPadding),
                            ValueListenableBuilder<List<Categories>>(
                              valueListenable: viewModel.categories,
                              builder: (context, categories, _) {
                                final uniqueCategories = categories
                                    .where((cat) => cat.isDelete != true)
                                    .toList();

                                if (selectedCategoryId != null &&
                                    !uniqueCategories.any((cat) =>
                                        cat.id == selectedCategoryId)) {
                                  selectedCategoryId = null;
                                }
                                return ValueListenableBuilder<
                                    List<CategoriesSub>>(
                                  valueListenable: viewModel.categoriesSub,
                                  builder: (context, categoriesSub, _) {
                                    if (kDebugMode) {
                                      print('Alt kategoriler: $categoriesSub');
                                      print(
                                          'Seçili kategori ID: $selectedCategoryId');
                                    }

                                    final uniqueCategoriesSub = categoriesSub
                                        .where((cat) =>
                                            cat.isDelete != true &&
                                            cat.categoryId ==
                                                selectedCategoryId)
                                        .toList();

                                    if (kDebugMode) {
                                      print(
                                          'Filtrelenmiş alt kategoriler: $uniqueCategoriesSub');
                                    }

                                    return Column(
                                      children: [
                                        context
                                            .myDropdownButtonFormField(
                                              labelText: 'Kategori',
                                              value: selectedCategoryId,
                                              items: uniqueCategories
                                                  .map((category) {
                                                return DropdownMenuItem(
                                                  value: category.id,
                                                  child: Text(
                                                      category.description),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                selectedCategoryId = value;
                                                if (value != null) {
                                                  viewModel
                                                      .loadCategoriesSub(value);
                                                }
                                                selectedCategorySubId = null;
                                              },
                                            )
                                            .paddingBottom(
                                                context.smallPadding),
                                        context
                                            .myDropdownButtonFormField(
                                              labelText: 'Alt Kategori',
                                              value: selectedCategorySubId,
                                              items: uniqueCategoriesSub
                                                  .map((category) {
                                                if (kDebugMode) {
                                                  print(
                                                      'Alt kategori ID: ${category.id}, Açıklama: ${category.description}');
                                                }
                                                return DropdownMenuItem(
                                                  value: category.id,
                                                  child: Text(
                                                      category.description),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                if (kDebugMode) {
                                                  print(
                                                      'Seçilen alt kategori ID: $value');
                                                }
                                                selectedCategorySubId = value;
                                              },
                                            )
                                            .paddingBottom(
                                                context.smallPadding),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: context.smallPadding,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            ValueListenableBuilder<List<Brands>>(
                              valueListenable: viewModel.brands,
                              builder: (context, brands, _) {
                                final uniqueBrands = brands
                                    .where((brand) => brand.isDelete != true)
                                    .toList();

                                if (selectedBrandId != null &&
                                    !uniqueBrands.any((brand) =>
                                        brand.id == selectedBrandId)) {
                                  selectedBrandId = null;
                                }

                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Marka',
                                      value: selectedBrandId,
                                      items: uniqueBrands.map((brand) {
                                        return DropdownMenuItem(
                                          value: brand.id,
                                          child: Text(brand.description),
                                        );
                                      }).toList(),
                                      onChanged: (value) =>
                                          selectedBrandId = value,
                                      validator: (value) => value == null
                                          ? 'Marka seçiniz'
                                          : null,
                                    )
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            ValueListenableBuilder<List<ProductUnits>>(
                              valueListenable: viewModel.productUnits,
                              builder: (context, units, _) {
                                final uniqueUnits = units
                                    .where((unit) => unit.isDelete != true)
                                    .toList();

                                if (selectedUnitId != null &&
                                    !uniqueUnits.any(
                                        (unit) => unit.id == selectedUnitId)) {
                                  selectedUnitId = null;
                                }

                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Birim',
                                      value: selectedUnitId,
                                      items: uniqueUnits.map((unit) {
                                        return DropdownMenuItem(
                                          value: unit.id,
                                          child: Text(unit.description),
                                        );
                                      }).toList(),
                                      onChanged: (value) =>
                                          selectedUnitId = value,
                                      validator: (value) => value == null
                                          ? 'Birim seçiniz'
                                          : null,
                                    )
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            context
                                .myTextFormField(
                                  labelText: 'Fiyat',
                                  controller: priceController,
                                  validator: (value) => value?.isEmpty == true
                                      ? 'Fiyat gerekli'
                                      : null,
                                )
                                .paddingBottom(context.smallPadding),
                            context
                                .myTextFormField(
                                  labelText: 'Boyutlar',
                                  controller: dimensionsController,
                                  validator: (value) => value?.isEmpty == true
                                      ? 'Boyutlar gerekli'
                                      : null,
                                )
                                .paddingBottom(context.smallPadding),
                            context
                                .myTextFormField(
                                  labelText: 'Ağırlık',
                                  controller: weightController,
                                  validator: (value) => value?.isEmpty == true
                                      ? 'Ağırlık gerekli'
                                      : null,
                                )
                                .paddingBottom(context.smallPadding),
                          ],
                        ),
                      ),
                    ],
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
                    await viewModel.updateProduct(
                      product.id!,
                      barcodeController.text,
                      codeController.text,
                      descriptionController.text,
                      selectedBrandId ?? 0,
                      selectedCategoryId ?? 0,
                      selectedCategorySubId ?? 0,
                      selectedUnitId ?? 0,
                      double.parse(priceController.text),
                      dimensionsController.text,
                      double.parse(weightController.text),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } catch (e) {
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
