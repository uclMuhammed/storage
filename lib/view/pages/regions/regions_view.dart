library regions;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'regions_view_model.dart';

part 'regions_desktop.dart';
part 'regions_tablet.dart';
part 'regions_mobile.dart';
part 'regions_body.dart';
part 'dialog/regions_create.dart';
part 'dialog/regions_edit.dart';
part 'dialog/regions_delete.dart';

class RegionsView extends BaseView {
  const RegionsView({super.key});
  @override
  Widget buildDesktopView(BuildContext context) {
    return _RegionsDesktop();
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return _RegionsMobile();
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return _RegionsTablet();
  }
}
