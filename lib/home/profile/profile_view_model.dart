part of 'profile_view.dart';

mixin ProfileViewModel on State<ProfileView> {
  Widget _currentPage = const EditProfileView();

  void navigateToPage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> handleLogout() async {
    // TODO: Çıkış işlemleri
  }
}
