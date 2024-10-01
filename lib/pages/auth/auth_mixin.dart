part of 'auth_page.dart';

mixin AuthPageMixin on State<AuthPage> {
  final List<Users> _userList = [];

  int _selectedPageIndex = 0; // Mevcut sayfa indeksi

  void _addUser(String email, String password) {
    setState(() {
      _userList.add(
        Users(
            id: 1,
            code: 1,
            email: email,
            password: password,
            isOwner: true,
            isAdmin: true,
            isActive: true,
            isDelete: false,
            createDat: DateTime.now(),
            updateDat: DateTime.now(),
            deleteDat: DateTime.now(),
            createBy: "",
            updatedBy: "",
            deletedBy: ""),
      );
    });
  }

  bool _authenticateUser(String email, String password) {
    return _userList.any(
      (user) => user.email == email && user.password == password,
    );
  }

  final PageController _pageController = PageController();
}
