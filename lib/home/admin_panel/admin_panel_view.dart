import 'package:flutter/material.dart';
import 'package:storage/home/admin_panel/limits/limits_view.dart';
import 'package:storage/home/admin_panel/my_plan/my_plans_view.dart';
import 'package:widgets/index.dart';

import 'staff/staff_view.dart';

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({super.key});

  @override
  State<AdminPanelView> createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, size),
          medium: _buildTabletLayout(context, size),
          large: _buildDesktopLayout(context, size),
        );
      },
    );
  }

  Widget _currentPage = const LimitsView();

  void _navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  //----------------------------------------------------------------------------
  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: context.isSmallScreen
          ? context.myTextFormField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.borderRadius),
                ),
              ),
            )
          : context.myText(text: "Admin Panel"),
      actions: [
        context.isSmallScreen
            ? IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              )
            : const SizedBox(),
      ],
    );
  }

  _menu(BuildContext context, BoxConstraints size) {
    return Expanded(
      child: Container(
        width: size.maxWidth * 0.3,
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: context.padding),
            context.myShortCutButton(
              name: 'Staff',
              icon: Icons.person,
              onTap: () {
                _navigateToPage(const StaffView());
              },
            ),
            context.myShortCutButton(
              name: 'My Plan',
              icon: Icons.card_membership,
              onTap: () {
                _navigateToPage(const MyPlansView());
              },
            ),
            context.myShortCutButton(
              name: 'Limits',
              icon: Icons.bar_chart,
              onTap: () {
                _navigateToPage(const LimitsView());
              },
            ),
          ],
        ),
      ),
    );
  }
  //----------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _menu(context, size),
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
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(context.borderRadius),
                ),
              ),
              child: Column(
                children: [
                  _appBar(),
                  _menu(context, size),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: _currentPage,
          ),
        ],
      ),
    );
  }
}
