library unit;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

import 'unit_view_model.dart';

part 'unit_body.dart';
part 'dialog/unit_create.dart';
part 'dialog/unit_delete.dart';
part 'dialog/unit_update.dart';

class UnitView extends BaseView {
  final UnitBody body;
  UnitView({super.key}) : body = UnitBody();

  @override
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
