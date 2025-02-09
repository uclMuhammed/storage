library regions;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import 'regions_view_model.dart';

part 'regions_body.dart';
part 'dialog/regions_create.dart';
part 'dialog/regions_edit.dart';
part 'dialog/regions_delete.dart';

class RegionsView extends BaseView {
  final RegionsBody body;
  RegionsView({super.key}) : body = RegionsBody();
  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);
}
