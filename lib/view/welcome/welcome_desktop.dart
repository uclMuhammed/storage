part of 'welcome_view.dart';

class _WelcomeDesktop extends StatelessWidget with _WelcomeDesktopMixin {
  _WelcomeDesktop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWithSideBar(
        sideBar: _WelcomeDrawer(drawerNotifier: notifier, viewKey: viewKey),
        body: const Text('Welcome Desktop'),
      ),
    );
  }
}

mixin _WelcomeDesktopMixin {
  final notifier = GenericNotifier<DrawerMode>(DrawerMode.icon);
  final Key viewKey = const Key('_WelcomeTabletDrawer');
}
