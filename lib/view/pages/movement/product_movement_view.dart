library product_movement_view;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'product_movement_view_model.dart';

part 'product_movement_body.dart';
part 'dialog/product_movement_create.dart';
part 'dialog/product_movement_delete.dart';
part 'dialog/product_movement_update.dart';

class ProductMovementView extends BaseView {
  final ProductMovementBody body;
  ProductMovementView({super.key}) : body = ProductMovementBody();
  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);
}
