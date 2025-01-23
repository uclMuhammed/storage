import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class ProductView extends BaseView {
  const ProductView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Product - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Product - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Product - Tablet View'));
  }
}
