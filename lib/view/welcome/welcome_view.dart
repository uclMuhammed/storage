import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'welcome_mixin.dart';

part 'welcome_desktop.dart';
part 'welcome_mobile.dart';
part 'welcome_tablet.dart';

class WelcomePage extends BaseView<WelcomePageMixin> {
  final WelcomePageMixin viewModel;
  const WelcomePage({super.key, required this.viewModel});

  @override
  Widget buildDesktopView(BuildContext context) {
    return WelcomeDesktop(viewModel: viewModel);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return WelcomeMobile(viewModel: viewModel);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return WelcomeDesktop(viewModel: viewModel);
  }
}
