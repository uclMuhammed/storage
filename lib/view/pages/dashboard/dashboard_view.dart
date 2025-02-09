library dashboard;

import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'dashboard_view_model.dart';

part 'dashboard_body.dart';
part 'dashboard_desktop.dart';
part 'dashboard_mobile.dart';
part 'dashboard_tablet.dart';

class DashboardView extends BaseView<DashboardViewModel> {
  const DashboardView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) => const _DashboardDesktop();

  @override
  Widget buildMobileView(BuildContext context) => const _DashboardMobile();

  @override
  Widget buildTabletView(BuildContext context) => const _DashboardTablet();
}
