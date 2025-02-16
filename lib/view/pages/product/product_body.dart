part of 'product_view.dart';

class ProductBody {
  final viewModel = ProductViewModel();

  Widget build(BuildContext context) {
    viewModel.setContext(context);
    viewModel.init();

    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error.value != null) {
          return Center(child: Text(viewModel.error.value!));
        }

        return Column(
          children: [
            Expanded(
              flex: 1,
              child: buildHeader(context),
            ),
            Expanded(
              flex: 3,
              child: buildBody(context),
            ),
          ],
        );
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return ValueListenableBuilder<List<Products>>(
      valueListenable: viewModel.products,
      builder: (context, products, _) {
        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding / 2,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: products
              .map(
                (product) => context.myCard(
                  onTap: () {
                    viewModel.selectedProduct.value = product;
                  },
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  context.mySubText(text: product.description),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            context.myText(
                              text: '#${product.id}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.inventory,
                              size: context.iconSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<Products?>(
      valueListenable: viewModel.selectedProduct,
      builder: (context, selectedProduct, _) {
        if (selectedProduct == null) {
          return const Center(child: Text('Lütfen bir ürün seçiniz'));
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.borderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //başlık
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.smallPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(context.borderRadius),
                    ),
                    child: context.mySubheadingText(
                      text: '#${selectedProduct.code}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  if (context.isMediumScreen || context.isLargeScreen)
                    context.mySubheadingText(text: 'Ürün Detayları'),
                  buildFooter(context),
                ],
              ),
              const Divider(),
              //detaylar
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'ÜRÜN',
                        value: selectedProduct.description,
                      ),
                      ValueListenableBuilder<List<Brands>>(
                        valueListenable: viewModel.brands,
                        builder: (context, brands, _) {
                          final brand = brands.firstWhere(
                            (brand) => brand.id == selectedProduct.brandId,
                            orElse: () => Brands.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.branding_watermark,
                            label: 'Marka',
                            value: brand.description,
                          );
                        },
                      ),
                      ValueListenableBuilder<List<Categories>>(
                        valueListenable: viewModel.categories,
                        builder: (context, categories, _) {
                          final category = categories.firstWhere(
                            (category) =>
                                category.id == selectedProduct.categoryId,
                            orElse: () => Categories.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.category,
                            label: 'Kategori',
                            value: category.description,
                          );
                        },
                      ),
                      ValueListenableBuilder<List<CategoriesSub>>(
                        valueListenable: viewModel.categoriesSub,
                        builder: (context, categoriesSub, _) {
                          final categorySub = categoriesSub.firstWhere(
                            (categorySub) =>
                                categorySub.id == selectedProduct.categoryId,
                            orElse: () => CategoriesSub.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.category,
                            label: 'Alt Kategori',
                            value: categorySub.description,
                          );
                        },
                      ),
                      ValueListenableBuilder<List<ProductUnits>>(
                        valueListenable: viewModel.productUnits,
                        builder: (context, units, _) {
                          final unit = units.firstWhere(
                            (unit) => unit.id == selectedProduct.unitId,
                            orElse: () => ProductUnits.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.abc,
                            label: 'Birim',
                            value: unit.description,
                          );
                        },
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.barcode_reader,
                        label: 'Barkod',
                        value: selectedProduct.barcode,
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.code,
                        label: 'Kod',
                        value: selectedProduct.code,
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.attach_money,
                        label: 'Fiyat',
                        value: selectedProduct.price.toString(),
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'Boyut',
                        value: selectedProduct.dimensions.toString(),
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.scale,
                        label: 'Ağırlık',
                        value: selectedProduct.weight.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingAll(context.smallPadding),
        ).paddingAll(context.smallPadding);
      },
    );
  }

  Widget buildFooter(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              ProductDelete(
                context: context,
                viewModel: viewModel,
                product: viewModel.selectedProduct.value ?? Products.empty(),
              ).show();
            },
            tooltip: 'Ürün Sil',
            heroTag: 'delete',
            child: const Icon(Icons.delete),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            onPressed: () {
              ProductEdit(
                context: context,
                viewModel: viewModel,
                product: viewModel.selectedProduct.value ?? Products.empty(),
              ).show();
            },
            tooltip: 'Ürün Düzenle',
            heroTag: 'edit',
            child: const Icon(Icons.edit),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            onPressed: () {
              ProductCreate(
                context: context,
                viewModel: viewModel,
              ).show();
            },
            tooltip: 'Ürün Ekle',
            heroTag: 'add',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
