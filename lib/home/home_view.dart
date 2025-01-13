import 'package:flutter/material.dart';
import 'package:storage/home/deneme/testpage.dart';
import 'package:storage/home/product/products_view.dart';
import 'package:storage/home/regions/regions_view.dart';
import 'package:storage/home/settings/settings_view.dart';
import 'package:storage/home/suppliers/suppliers_view.dart';
import 'package:storage/routes/navigation_service.dart';
import 'package:widgets/index.dart';

import '../auth/auth_manager/auth_manager.dart';
import 'admin_panel/admin_panel_view.dart';
import 'brands/brands_view.dart';
import 'category/category_view.dart';
import 'main_menu/main_menu_view.dart';
import '../routes/app_routes.dart';
import 'warehouses/warehouses_view.dart';
part 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewModel<HomeView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, size),
          medium: _buildTabletLayout(context, size),
          large: _buildDesktopLayout(context, size),
        );
      },
    );
  }
  //---------------------------------------------------------------------------

  Widget _currentPage = const MainMenuView();

  void _navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  AuthManager authManager = AuthManager();

  Widget _menu(BuildContext context, BoxConstraints size) {
    return Container(
      width: context.isMediumScreen ? 150 : 200,
      height: size.maxHeight,
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profil Bölümü
            Text(
              'STOKLARIM.com',
              style: TextStyle(
                fontSize: context.smallTextSize,
                fontWeight: FontWeight.bold,
              ),
            ).paddingAll(context.smallPadding),
            // Menü Öğeleri
            context.myLine(),
            context.myShortCutButton(
              name: 'Main Menu',
              icon: Icons.dashboard,
              onTap: () {
                _navigateToPage(
                  const MainMenuView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Warehouses',
              icon: Icons.warehouse,
              onTap: () {
                _navigateToPage(
                  const WarehousesView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Products',
              icon: Icons.inventory,
              onTap: () {
                _navigateToPage(
                  const ProductsView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Brands',
              icon: Icons.branding_watermark,
              onTap: () {
                _navigateToPage(
                  const BrandsView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Categories',
              icon: Icons.category,
              onTap: () {
                _navigateToPage(
                  const CategoriesView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Suppliers',
              icon: Icons.supervised_user_circle,
              onTap: () {
                _navigateToPage(
                  const SuppliersView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Regions',
              icon: Icons.location_city,
              onTap: () {
                _navigateToPage(
                  const RegionsView(),
                );
              },
            ),
            context.myLine(),
            SizedBox(height: context.padding),
            context.myShortCutButton(
              name: 'ADMIN PANEL',
              icon: Icons.admin_panel_settings,
              onTap: () {
                NavigationService.navigatorKey.currentState!
                    .pushNamed(AppRoutes.adminPanel);
              },
            ),
            context.myShortCutButton(
              name: 'DEVELOPER TEST',
              icon: Icons.code,
              onTap: () {
                _navigateToPage(
                  const TestPage(),
                );
              },
            ),
            SizedBox(height: context.padding),
            context.myShortCutButton(
              name: 'Settings',
              icon: Icons.settings,
              onTap: () {
                _navigateToPage(
                  const SettingsView(),
                );
              },
            ),
            context.myShortCutButton(
              name: 'Logout',
              icon: Icons.logout,
              onTap: () {
                authManager.logout().then((value) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.welcome,
                    (route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: context.myTextFormField(
        controller: search,
        decoration: InputDecoration(
          hintText: 'Ara...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.borderRadius),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            NavigationService.navigatorKey.currentState!
                .pushNamed(AppRoutes.profile);
          },
        ),
      ],
    );
  }
  //----------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      drawer: _menu(context, size),
      appBar: _appBar(),
      body: _currentPage,
    );
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints size) {
    return _buildDesktopLayout(context, size);
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      body: Row(
        children: [
          _menu(context, size),
          Expanded(
            child: Column(
              children: [
                _appBar(),
                Expanded(
                  child: _currentPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
