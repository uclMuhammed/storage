import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class DailyReportView extends BaseView {
  const DailyReportView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Daily Report - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Daily Report - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Daily Report - Tablet View'));
  }
}
