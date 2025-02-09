library category;

import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'category_view_model.dart';

part 'category_body.dart';
part 'dialog/category_create.dart';
part 'dialog/category_delete.dart';
part 'dialog/category_edit.dart';

class CategoryView extends BaseView {
  final CategoryBody body;
  CategoryView({super.key}) : body = CategoryBody();

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
