library suppliers;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'suppliers_view_model.dart';

part 'suppliers_body.dart';
part 'dialog/suppliers_create.dart';
part 'dialog/suppliers_edit.dart';
part 'dialog/suppliers_delete.dart';

class SuppliersView extends BaseView {
  final SuppliersBody body;
  SuppliersView({super.key}) : body = SuppliersBody();

  @override
  Widget buildDesktopView(BuildContext context) {
    return body.build(context);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return body.build(context);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return body.build(context);
  }
}
