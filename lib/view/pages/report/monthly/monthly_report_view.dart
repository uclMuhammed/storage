import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class MonthlyReportView extends BaseView {
  const MonthlyReportView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return const Center(child: Text('Monthly Report - Desktop View'));
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const Center(child: Text('Monthly Report - Mobile View'));
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const Center(child: Text('Monthly Report - Tablet View'));
  }
}
