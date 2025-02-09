library brands;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

import 'brands_view_model.dart';

part 'brands_body.dart';
part 'dialog/brands_create.dart';
part 'dialog/brands_edit.dart';
part 'dialog/brands_delete.dart';

class BrandsView extends BaseView {
  final BrandsBody _body;
  BrandsView({super.key}) : _body = BrandsBody();

  @override
  Widget buildDesktopView(BuildContext context) {
    return _body.build(context);
  }

  @override
  Widget buildMobileView(BuildContext context) {
    return _body.build(context);
  }

  @override
  Widget buildTabletView(BuildContext context) {
    return _body.build(context);
  }
}
