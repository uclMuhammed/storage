import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class CategoryView extends BaseView {
  const CategoryView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Category - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Category - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Category - Tablet View'));
  }
}
