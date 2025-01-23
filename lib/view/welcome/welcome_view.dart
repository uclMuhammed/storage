import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import '../../features/routes/route_constants.dart';
import '../../features/routes/route_manager.dart';
import 'welcome_view_model.dart';

part 'welcome_desktop.dart';
part 'welcome_mobile.dart';
part 'welcome_tablet.dart';
part 'welcome_body.dart';

class WelcomeView extends BaseView<WelcomeViewModel> {
  final WelcomeViewModel viewModel;
  final WelcomeBody body;
  const WelcomeView({super.key, required this.viewModel, required this.body});

  @override
  Widget buildDesktopView(BuildContext context) {
    return WelcomeDesktop(viewModel: viewModel, body: body);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return WelcomeMobile(viewModel: viewModel, body: body);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return WelcomeDesktop(viewModel: viewModel, body: body);
  }
}
