part of 'auth_page.dart';

mixin AuthPageMixin on State<AuthPage> {
  final List<User> _userList = [];

  int _selectedPageIndex = 0; // Mevcut sayfa indeksi

  void _addUser(String username, String password) {
    setState(() {
      _userList.add(User(name: username, password: password));
    });
  }

  bool _authenticateUser(String username, String password) {
    return _userList.any(
      (user) => user.name == username && user.password == password,
    );
  }

  final PageController _pageController = PageController();
}
