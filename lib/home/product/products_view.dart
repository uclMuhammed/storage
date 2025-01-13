import 'package:backend/backend.dart';
import 'package:backend/service/product_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets/index.dart';
part 'products_view_model.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> with ProductsViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  // -----------------------------------------------------------
  Widget _addProduct() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: createProduct,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _productsGridList() {
    if (products.isEmpty) {
      return const Center(child: Text('Ürün bulunamadı'));
    }

    return SizedBox(
      height: context.cardHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          context.responsiveGridView(
            crossAxiscount: 1,
            padding: EdgeInsets.all(context.smallPadding),
            childAspectRatio: 1,
            children: products.map((product) {
              return context.myCard(
                onTap: () => setState(() => selectedProduct = product),
                title: product.description,
                subtitle: 'Kod: ${product.code}',
                icon: Icons.inventory,
                isSelected: selectedProduct?.id == product.id,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _productsDetails() {
    if (selectedProduct == null) {
      return const Center(
        child: Text('Lütfen bir ürün seçin'),
      );
    }

    return Card(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.inventory, color: Colors.white),
                    title: context.mySubheadingText(text: 'Ürün Adı'),
                    subtitle: context.myText(
                        text: selectedProduct?.description ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: context.mySubheadingText(text: "|||"),
                    title: context.mySubheadingText(text: 'Barkod'),
                    subtitle: context.myText(
                        text: selectedProduct?.barcode ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: const Icon(Icons.code, color: Colors.white),
                    title: context.mySubheadingText(text: 'Kod'),
                    subtitle: context.myText(
                        text: selectedProduct?.code ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: const Icon(Icons.branding_watermark),
                    title: context.mySubheadingText(text: 'Marka'),
                    subtitle: context.myText(
                        text: selectedProduct?.brandId.toString() ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: context.mySubheadingText(text: 'Kategori'),
                    subtitle: context.myText(
                        text: selectedProduct?.categoryId.toString() ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: const Icon(Icons.stacked_bar_chart),
                    title: context.mySubheadingText(text: 'Unit'),
                    subtitle: context.myText(
                        text: selectedProduct?.unitId.toString() ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: const Icon(Icons.price_change),
                    title: context.mySubheadingText(text: 'Fiyat'),
                    subtitle: context.myText(
                        text: selectedProduct?.price.toString() ?? '',
                        textAlign: TextAlign.start),
                  ),
                  ListTile(
                    leading: const Icon(Icons.line_weight),
                    title: context.mySubheadingText(text: 'Ağırlık'),
                    subtitle: context.myText(
                        text: selectedProduct?.weight.toString() ?? '',
                        textAlign: TextAlign.start),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () => editProduct(selectedProduct!),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ).paddingAll(context.smallPadding),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () => deleteProduct(selectedProduct!),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ).paddingAll(context.smallPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Column(
          children: [
            Row(
              children: [
                context.mySubheadingText(text: 'Products'),
                const Spacer(),
                _addProduct(),
              ],
            ).paddingHorizontal(context.smallPadding),
            _productsGridList(),
            Expanded(
                child: _productsDetails().paddingAll(context.smallPadding)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Expanded(
        flex: 12,
        child: Column(
          children: [
            Row(
              children: [
                context
                    .mySubheadingText(text: 'Products')
                    .paddingLeft(context.smallPadding),
                const Spacer(),
                _addProduct().paddingRight(context.smallPadding),
              ],
            ),
            _productsGridList(),
            Expanded(
              child: _productsDetails().paddingAll(context.smallPadding),
            ),
          ],
        ),
      ),
    );
  }
}
