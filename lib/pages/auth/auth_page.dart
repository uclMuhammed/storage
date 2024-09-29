import 'package:core/user/index.dart';
import 'package:flutter/material.dart';
import 'package:storage/pages/auth/loginpage/login_page.dart';
import 'package:storage/pages/auth/signup_page/signup_page.dart';

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
      appBar: AppBar(
        title: const Text('Storage'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index; // Mevcut sayfa güncellenir
          });
        },
        children: [
          SignUpScreen(addUser: _addUser),
          LoginScreen(authenticateUser: _authenticateUser),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), label: 'Kayıt Ol'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Giriş Yap'),
        ],
      ),
    );
  }
}
