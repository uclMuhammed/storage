import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/features/routes/routes.dart';
import 'package:storage/view/pages/home/home_view_model.dart';
import 'package:widgets/widgets.dart';

import '../../../features/data/drawer_data.dart';

part 'home_desktop.dart';
part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_body.dart';
part 'component/drawer.dart';
part './component/appbar.dart';

class HomeView extends BaseView {
  const HomeView({super.key});

  @override
  Widget buildMobileView(BuildContext context) {
    return HomeMobile();
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return HomeTablet();
  }

  @override
  Widget buildDesktopView(BuildContext context) {
    return HomeDesktop();
  }
}
