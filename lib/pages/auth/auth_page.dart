import 'package:core/base/users/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/base_services/base_service.dart';
import 'package:storage/base_services/services/auth_services.dart';
import 'package:storage/pages/auth/loginpage/login_page.dart';
import 'package:storage/pages/auth/signup_page/signup_page.dart';
import 'package:storage/pages/home/home_page.dart';

part 'auth_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthPageMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Kayıt'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Giriş'),
        ],
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (pageIndex) {
          setState(() {
            _selectedPageIndex = pageIndex;
          });
        },
        children: [
          SignUpScreen(addUser: _addUser),
          LoginScreen(authenticateUser: _authenticateUser),
        ],
      ),
    );
  }
}
