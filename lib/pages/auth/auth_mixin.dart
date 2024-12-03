part of 'auth_page.dart';

mixin AuthPageMixin on State<AuthPage> {
  AuthManager authManager = AuthManager();
  AuthenticationService auth = AuthenticationService();
  int _selectedPageIndex = 0; // Mevcut sayfa indeksi"

  void _loadAuthorities() async {
    try {
      await auth.init();
      await authManager.checkLoginStatus();
      final token = await auth.storage?.read(BearerTokenKey);
      if (kDebugMode) {
        print(token);
      }
      if (token != null) {
        if (kDebugMode) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                authManager: authManager,
              ),
            ),
          );
        }
      } else {
        if (kDebugMode) print('Token Not Found');
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAuthorities();
  }

  final PageController _pageController = PageController();
}
