library warehouses;

import 'package:flutter/material.dart';
import 'package:backend/backend.dart';
import 'package:widgets/widgets.dart';

import 'warehouses_view_model.dart';

part 'warehouses_desktop.dart';
part 'warehouses_tablet.dart';
part 'warehouses_mobile.dart';
part 'warehouses_body.dart';
part 'dialog/warehouses_edit.dart';
part 'dialog/warehouses_create.dart';
part 'dialog/warehouses_delete.dart';

class WarehousesView extends BaseView<WarehousesViewModel> {
  const WarehousesView({super.key});

  @override
  Widget buildDesktopView(BuildContext context) {
    return _WarehousesDesktop();
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return _WarehousesMobile();
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return _WarehousesTablet();
  }
}
