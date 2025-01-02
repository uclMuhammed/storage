import 'package:flutter/material.dart';
import 'package:widgets/index.dart';
part 'products_view_model.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _productsGridList() {
    return SizedBox(
      height: context.cardHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          context.responsiveGridView(
            crossAxiscount: 1,
            padding: EdgeInsets.all(context.smallPadding),
            childAspectRatio: 1,
            children: List.generate(
              10,
              (index) {
                return context.myCard(
                  onTap: () {},
                  title: 'Card',
                  subtitle: 'Subtitle',
                  icon: Icons.inventory,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _productsDetails() {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Product',
              style: TextStyle(
                fontSize: context.bodySize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).paddingLeft(context.smallPadding),
        ],
      ),
    );
  }
  //------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildTabletLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 12,
            child: Column(
              children: [
                Row(
                  children: [
                    context
                        .mySubheadingText(text: 'Products')
                        .paddingLeft(context.smallPadding),
                    Spacer(),
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
        ],
      ),
    );
  }
}
