import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class WeeklyReportView extends BaseView {
  const WeeklyReportView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Weekly Report - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Weekly Report - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Weekly Report - Tablet View'));
  }
}
