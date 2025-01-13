import 'package:flutter/material.dart';
import 'package:widgets/index.dart';
import 'edit_profile/edit_profile_view.dart';

part 'profile_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  Widget _menu(BuildContext context) {
    return Container(
      width: context.isSmallScreen || context.isMediumScreen ? 160 : 300,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBar(context),
          userAccountsDrawerHeader(),
          context.myShortCutButton(
            name: 'Profile',
            icon: Icons.person_rounded,
            onTap: () => navigateToPage(const EditProfileView()),
          ),
          const Spacer(),
          context
              .myShortCutButton(
                name: 'Logout',
                icon: Icons.logout,
                onTap: handleLogout,
              )
              .paddingBottom(context.padding),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: context.mySubheadingText(text: 'Profile'),
    );
  }

  UserAccountsDrawerHeader userAccountsDrawerHeader() {
    return const UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://api.dicebear.com/7.x/avataaars/svg?seed=John'),
      ),
      decoration: BoxDecoration(color: Colors.black),
      accountName: Text('John Doe'),
      accountEmail: Text('I0l7m@example.com'),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: Column(
          children: [
            userAccountsDrawerHeader(),
            Expanded(child: _currentPage),
          ],
        ));
  }

  Widget _buildTabletLayout(BuildContext context) {
    return _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _menu(context),
          Expanded(child: _currentPage),
        ],
      ),
    );
  }
}
