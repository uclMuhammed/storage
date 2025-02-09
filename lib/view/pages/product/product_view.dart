library product;

import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'product_view_model.dart';
part 'product_body.dart';
part 'dialog/product_edit.dart';
part 'dialog/product_delete.dart';
part 'dialog/product_create.dart';

class ProductView extends BaseView {
  final ProductBody body;
  ProductView({super.key}) : body = ProductBody();
  @override
  Widget buildDesktopView(BuildContext context) => body.build(context);

  @override
  Widget buildMobileView(BuildContext context) => body.build(context);

  @override
  Widget buildTabletView(BuildContext context) => body.build(context);
}
