import 'package:flutter/material.dart';
import 'package:storage/view/pages/admin_panel/admin_panel.dart';
import 'package:storage/view/pages/brands/brands_view.dart';
import 'package:storage/view/pages/category/category_view.dart';
import 'package:storage/view/pages/dashboard/dashbord_view.dart';
import 'package:storage/view/pages/developer/developer_view.dart';
import 'package:storage/view/pages/product/product_view.dart';
import 'package:storage/view/pages/regions/regions_view.dart';
import 'package:storage/view/pages/report/daily/daily_report_view.dart';
import 'package:storage/view/pages/report/monthly/monthly_report_view.dart';
import 'package:storage/view/pages/report/weekly/weekly_report.dart';
import 'package:storage/view/pages/suppliers/suppliers_view.dart';
import 'package:storage/view/pages/warehouses/warehouses_view.dart';

import '../models/drawer_model.dart';

class DrawerData extends ChangeNotifier {
  static List<DrawerModel> drawerModels = [
    DrawerModel(
      title: 'DASHBORD',
      icon: Icons.dashboard,
      page: const DashboardView(),
    ),
    DrawerModel(
      title: 'WAREHOUSES',
      icon: Icons.warehouse,
      page: const WarehousesView(),
    ),
    DrawerModel(
      title: 'PRODUCTS',
      icon: Icons.inventory,
      page: const ProductView(),
    ),
    DrawerModel(
      title: 'BRANDS',
      icon: Icons.branding_watermark,
      page: const BrandsView(),
    ),
    DrawerModel(
      title: 'CATEGORIES',
      icon: Icons.category,
      page: const CategoryView(),
    ),
    DrawerModel(
      title: 'SUPPLIERS',
      icon: Icons.supervised_user_circle,
      page: const SuppliersView(),
    ),
    DrawerModel(
      title: 'REGIONS',
      icon: Icons.location_city,
      page: const RegionsView(),
    ),
    DrawerModel(
      title: 'ADMIN PANEL',
      icon: Icons.admin_panel_settings,
      page: const AdminPanelView(),
    ),
    DrawerModel(
      title: 'DEVELOPER',
      icon: Icons.developer_board,
      page: const DeveloperView(),
    ),
  ];

  static List<DrawerModel> reportDrawerModels = [
    DrawerModel(
      title: 'Günlük Rapor',
      icon: Icons.report,
      page: const DailyReportView(),
    ),
    DrawerModel(
      title: 'Haftalık Rapor',
      icon: Icons.report,
      page: const WeeklyReportView(),
    ),
    DrawerModel(
      title: 'Aylık Rapor',
      icon: Icons.report,
      page: const MonthlyReportView(),
    ),
  ];

  static List<DrawerModel> getDrawerPage = [
    DrawerModel(
      title: 'Günlük Rapor',
      icon: Icons.report,
      page: const DailyReportView(),
    ),
    DrawerModel(
      title: 'Haftalık Rapor',
      icon: Icons.report,
      page: const WeeklyReportView(),
    ),
    DrawerModel(
      title: 'Aylık Rapor',
      icon: Icons.report,
      page: const MonthlyReportView(),
    ),
    DrawerModel(
      title: 'DASHBORD',
      icon: Icons.dashboard,
      page: const DashboardView(),
    ),
    DrawerModel(
      title: 'WAREHOUSES',
      icon: Icons.warehouse,
      page: const WarehousesView(),
    ),
    DrawerModel(
      title: 'PRODUCTS',
      icon: Icons.inventory,
      page: const ProductView(),
    ),
    DrawerModel(
      title: 'BRANDS',
      icon: Icons.branding_watermark,
      page: const BrandsView(),
    ),
    DrawerModel(
      title: 'CATEGORIES',
      icon: Icons.category,
      page: const CategoryView(),
    ),
    DrawerModel(
      title: 'SUPPLIERS',
      icon: Icons.supervised_user_circle,
      page: const SuppliersView(),
    ),
    DrawerModel(
      title: 'REGIONS',
      icon: Icons.location_city,
      page: const RegionsView(),
    ),
    DrawerModel(
      title: 'ADMIN PANEL',
      icon: Icons.admin_panel_settings,
      page: const AdminPanelView(),
    ),
    DrawerModel(
      title: 'DEVELOPER',
      icon: Icons.developer_board,
      page: const DeveloperView(),
    ),
  ];
}
