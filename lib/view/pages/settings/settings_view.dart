import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class SettingsView extends BaseView {
  const SettingsView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Settings - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Settings - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Settings - Tablet View'));
  }
}
