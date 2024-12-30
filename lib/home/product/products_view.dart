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

  Widget _buildMobileLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildTabletLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Products',
            style: TextStyle(
              fontSize: context.bodySize,
              fontWeight: FontWeight.bold,
            ),
          ).paddingLeft(context.smallPadding),
          SizedBox(
            height: context.cardHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                context.responsiveGridView(
                  padding: EdgeInsets.all(context.smallPadding),
                  childAspectRatio: 1,
                  children: List.generate(
                    10,
                    (index) {
                      return context.myCard(
                        onTap: () {},
                        title: 'Title',
                        subtitle: 'Subtitle',
                        icon: Icons.inventory,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
