import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class RegionsView extends BaseView {
  const RegionsView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Regions - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Regions - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Regions - Tablet View'));
  }
}
