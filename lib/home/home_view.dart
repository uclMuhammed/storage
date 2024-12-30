import 'package:flutter/material.dart';
import 'package:storage/home/product/products_view.dart';
import 'package:storage/home/settings/settings_view.dart';
import 'package:widgets/index.dart';

import '../auth/auth_manager/auth_manager.dart';
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
      width: 250,
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
                  onTap: () {},
                ),
                context.myShortCutButton(
                  name: 'Categories',
                  icon: Icons.category,
                  onTap: () {},
                ),
                context.myShortCutButton(
                  name: 'Suppliers',
                  icon: Icons.supervised_user_circle,
                  onTap: () {},
                ),
                context.myShortCutButton(
                  name: 'Regions',
                  icon: Icons.location_city,
                  onTap: () {},
                ),
                const Spacer(),
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
                context.myShortCutButton(
                  name: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    _navigateToPage(
                      const SettingsView(),
                    );
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
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
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
