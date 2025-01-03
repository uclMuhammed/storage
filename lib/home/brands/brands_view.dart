import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  //----------------------------------------------
  Widget _addBrands() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _brandsGridList() {
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
                  icon: Icons.branding_watermark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _brandsDetails() {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Brands',
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
  //----------------------------------------------

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
                        .mySubheadingText(text: 'Brands')
                        .paddingLeft(context.smallPadding),
                    const Spacer(),
                    _addBrands().paddingRight(context.smallPadding),
                  ],
                ),
                _brandsGridList(),
                Expanded(
                  child: _brandsDetails().paddingAll(context.smallPadding),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
