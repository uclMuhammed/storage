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
        return buildMobileView(context);
      } else if (constraints.isTablet()) {
        return buildTabletView(context);
      } else {
        return buildDesktopView(context);
      }
    });
  }
}
