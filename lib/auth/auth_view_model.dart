part of 'auth_view.dart';

mixin AuthViewModel<T extends AuthView> on State<T> {
  final AuthManager _authManager = AuthManager();
  @override
  void initState() {
    super.initState();
    _authManager.checkLoginStatus();
    _authManager.isLoggedIn
        ? Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (route) => false)
        : null;
  }
}
