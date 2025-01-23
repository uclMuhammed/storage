import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class DashboardView extends BaseView {
  const DashboardView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Dashbord - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Dashbord - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Dashbord - Tablet View'));
  }
}
