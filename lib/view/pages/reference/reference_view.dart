library reference;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

import 'reference_view_model.dart';

part 'reference_body.dart';
part 'dialog/reference_create.dart';
part 'dialog/reference_delete.dart';
part 'dialog/reference_update.dart';

class ReferencesView extends BaseView {
  final ReferenceBody body;
  ReferencesView({super.key}) : body = ReferenceBody();

  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);
}
