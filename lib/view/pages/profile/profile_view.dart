import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class ProfileView extends BaseView {
  const ProfileView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Profile - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Profile - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Profile - Tablet View'));
  }
}
