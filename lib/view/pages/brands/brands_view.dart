import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

class BrandsView extends BaseView {
  const BrandsView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Brands - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Brands - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Brands - Tablet View'));
  }
}
