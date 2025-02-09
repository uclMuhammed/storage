import 'package:flutter/material.dart';
import 'package:storage/view/pages/admin_panel/admin_panel.dart';
import 'package:storage/view/pages/brands/brands_view.dart';
import 'package:storage/view/pages/category/category_view.dart';
import 'package:storage/view/pages/dashboard/dashboard_view.dart';
import 'package:storage/view/pages/developer/developer_view.dart';
import 'package:storage/view/pages/product/product_view.dart';
import 'package:storage/view/pages/regions/regions_view.dart';
import 'package:storage/view/pages/suppliers/suppliers_view.dart';
import 'package:storage/view/pages/tax_rate/tax_rate_view.dart';
import 'package:storage/view/pages/unit/unit_view.dart';
import 'package:storage/view/pages/warehouses/warehouses_view.dart';

import '../../view/pages/movement/product_movement_view.dart';
import '../../view/pages/project/porject_view.dart';
import '../../view/pages/reference/reference_view.dart';
import '../models/drawer_model.dart';

class DrawerData extends ChangeNotifier {
  static List<DrawerModel> drawerModels = [
    DrawerModel(
      title: 'DASHBORD',
      icon: Icons.dashboard,
      page: DashboardView(),
    ),
    DrawerModel(
      title: 'WAREHOUSES',
      icon: Icons.warehouse,
      page: WarehousesView(),
    ),
    DrawerModel(
      title: 'PRODUCTS',
      icon: Icons.inventory,
      page: ProductView(),
    ),
    DrawerModel(
      title: 'PRODUCT MOVEMENT',
      icon: Icons.move_to_inbox,
      page: ProductMovementView(),
    ),
    DrawerModel(
      title: 'UNIT\'S',
      icon: Icons.scale,
      page: UnitView(),
    ),
    DrawerModel(
      title: 'BRANDS',
      icon: Icons.branding_watermark,
      page: BrandsView(),
    ),
    DrawerModel(
      title: 'CATEGORIES',
      icon: Icons.category,
      page: CategoryView(),
    ),
    DrawerModel(
      title: 'SUPPLIERS',
      icon: Icons.supervised_user_circle,
      page: SuppliersView(),
    ),
    DrawerModel(
      title: 'REGIONS',
      icon: Icons.location_city,
      page: RegionsView(),
    ),
    DrawerModel(
      title: 'PROJECTS',
      icon: Icons.propane,
      page: ProjectView(),
    ),
    DrawerModel(
      title: 'REFERENCES',
      icon: Icons.refresh,
      page: ReferencesView(),
    ),
    DrawerModel(
      title: 'TAX RATES',
      icon: Icons.attach_money,
      page: TaxRateView(),
    ),
    DrawerModel(
      title: 'ADMIN PANEL',
      icon: Icons.admin_panel_settings,
      page: AdminPanelView(),
    ),
    DrawerModel(
      title: 'DEVELOPER',
      icon: Icons.developer_board,
      page: DeveloperView(),
    ),
    DrawerModel(
      title: 'LOG OUT',
      icon: Icons.logout,
    ),
  ];
}
