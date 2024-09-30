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
      body: Stack(
        children: [
          Positioned(
            top: -size.height * 0.3,
            left: -size.width * 0.3,
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(200.0),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -size.height * 0.3,
            right: -size.width * 0.3,
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200.0),
                ),
              ),
            ),
          ),
          PageView(
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
        ],
      ),
    );
  }
}
