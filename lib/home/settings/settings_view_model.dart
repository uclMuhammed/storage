part of 'settings_view.dart';

mixin SettingsViewModel<T extends SettingsView> on State<T> {
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
