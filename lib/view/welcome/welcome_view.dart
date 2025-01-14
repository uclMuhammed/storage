import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

part 'welcome_desktop.dart';
part 'welcome_mobile.dart';
part 'welcome_tablet.dart';

class WelcomeView extends BaseView {
  const WelcomeView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return const _WelcomeDesktop();
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return const _WelcomeMobile();
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return const _WelcomeTablet();
  }
}
