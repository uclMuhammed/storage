import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

import 'edit_profile/edit_profile_view.dart';
import 'limits/limits_view.dart';
import 'my_plan/my_plans_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  Widget _currentPage = const EditProfileView();

  void _navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  //--------------------------------------------------------------
  Widget _menu(BuildContext context) {
    return Container(
      width: context.isSmallScreen ? 160 : 300,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: Colors.black,
            title: context.mySubheadingText(text: 'Profile'),
          ),
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/200',
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            accountName: Text('John Doe'),
            accountEmail: Text('I0l7m@example.com'),
          ),
          context.myShortCutButton(
            name: 'Profile',
            icon: Icons.person_rounded,
            onTap: () {
              _navigateToPage(const EditProfileView());
            },
          ),
          context.myShortCutButton(
            name: 'Limits',
            icon: Icons.bar_chart_outlined,
            onTap: () {
              _navigateToPage(const LimitsView());
            },
          ),
          context.myShortCutButton(
            name: 'My Plan',
            icon: Icons.card_membership_outlined,
            onTap: () {
              _navigateToPage(const MyPlansView());
            },
          ),
          const Spacer(),
          context
              .myShortCutButton(
                name: 'Logout',
                icon: Icons.logout,
                onTap: () {},
              )
              .paddingBottom(context.padding),
        ],
      ),
    );
  }
  //--------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _menu(context),
          Expanded(
            child: _currentPage,
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _menu(context),
          Expanded(
            child: _currentPage,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _menu(context),
          Expanded(
            child: _currentPage,
          ),
        ],
      ),
    );
  }
}
