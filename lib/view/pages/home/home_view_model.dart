import 'package:flutter/material.dart';
import 'package:storage/view/pages/product/product_view.dart';
import 'package:widgets/base/base_view_model.dart';
import 'package:widgets/widgets.dart';

import '../../../features/data/drawer_data.dart';
import '../../../features/models/drawer_model.dart';

class HomeViewModel extends BaseViewModel {
  final drawerNotifier = GenericNotifier<DrawerMode>(DrawerMode.icon);
  final Key viewKey = const Key('_home_view_key');
  final ValueNotifier<bool> isSearchVisible = ValueNotifier(false);
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<Widget> currentPage = ValueNotifier(ProductView());
  final ValueNotifier<List<DrawerModel>> drawerModels =
      ValueNotifier(DrawerData.drawerModels);

  @override
  void init() {}
}
