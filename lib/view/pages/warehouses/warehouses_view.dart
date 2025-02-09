library warehouses;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:backend/backend.dart';
import 'package:storage/view/pages/warehouses/warehouses_view_model.dart';
import 'package:widgets/widgets.dart';

part 'warehouses_body.dart';
part 'dialog/warehouses_edit.dart';
part 'dialog/warehouses_create.dart';
part 'dialog/warehouses_delete.dart';

class WarehousesView extends BaseView<WarehousesViewModel> {
  final WarehousesBody body;
  WarehousesView({super.key}) : body = WarehousesBody();

  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);
}
