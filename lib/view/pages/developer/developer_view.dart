import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class DeveloperView extends BaseView {
  const DeveloperView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Developer - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Developer - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Developer - Tablet View'));
  }
}
