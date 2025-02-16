library dashboard;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import '../../../features/data/pie_chart_data.dart';
import '../../../features/data/time_filter_data.dart';
import '../../../features/models/time_filter_model.dart';
import 'dashboard_view_model.dart';
import 'package:fl_chart/fl_chart.dart';

part 'dashboard_body.dart';

class DashboardView extends BaseView<DashboardViewModel> {
  final DashboardBody body;
  DashboardView({super.key}) : body = DashboardBody();

  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);
}
