import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class SuppliersView extends BaseView {
  const SuppliersView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Suppliers - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Suppliers - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Suppliers - Tablet View'));
  }
}
