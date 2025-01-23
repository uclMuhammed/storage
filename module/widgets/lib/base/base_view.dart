import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'base_view_model.dart';

abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  const BaseView({super.key});

  Widget buildMobileView(BuildContext context);

  Widget buildTabletView(BuildContext context);

  Widget buildDesktopView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.isMobile()) {
        return SafeArea(child: buildMobileView(context));
      } else if (constraints.isTablet()) {
        return SafeArea(child: buildTabletView(context));
      } else {
        return SafeArea(child: buildDesktopView(context));
      }
    });
  }
}
