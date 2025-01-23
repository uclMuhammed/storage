import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class WarehousesView extends BaseView {
  const WarehousesView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Warehouses - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Warehouses - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Warehouses - Tablet View'));
  }
}
