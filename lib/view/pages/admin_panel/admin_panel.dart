import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class AdminPanelView extends BaseView {
  const AdminPanelView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Admin Panel - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Admin Panel - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Admin Panel - Tablet View'));
  }
}
