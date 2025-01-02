import 'package:flutter/material.dart';
import 'package:storage/home/deneme/testpage.dart';
import 'package:storage/home/product/products_view.dart';
import 'package:storage/home/regions/regions_view.dart';
import 'package:storage/home/settings/settings_view.dart';
import 'package:storage/home/suppliers/suppliers_view.dart';
import 'package:storage/routes/navigation_service.dart';
import 'package:widgets/index.dart';

import '../auth/auth_manager/auth_manager.dart';
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
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }
  //---------------------------------------------------------------------------

  Widget _currentPage = const WarehousesView();

  void _navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  AuthManager authManager = AuthManager();

  Widget _menu() {
    return Container(
      width: 200,
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil Bölümü
          Text(
            'STOKLARIM.com',
            style: TextStyle(
              fontSize: context.bodySize,
              fontWeight: FontWeight.bold,
            ),
          ).paddingAll(context.smallPadding),
          // Menü Öğeleri
          Expanded(
            child: Column(
              children: [
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
                const Spacer(),
                context.myShortCutButton(
                  name: 'TEST DEVELOPER',
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
                SizedBox(height: context.padding),
              ],
            ),
          ),
        ],
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

  Widget _buildMobileLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildTabletLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _menu(),
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
