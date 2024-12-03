import 'package:backend/backend.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/service/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import 'package:storage/pages/auth/login_page/login_page.dart';
import 'package:storage/pages/auth/signup_page/signup_page.dart';

import '../home/home_page.dart';

part 'auth_mixin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthPageMixin {
  @override
  Widget build(BuildContext context) {
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
        children: const [
          SignUpScreen(),
          LoginScreen(),
        ],
      ),
    );
  }
}
