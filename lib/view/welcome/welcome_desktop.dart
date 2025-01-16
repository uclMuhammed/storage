part of 'welcome_view.dart';

class _WelcomeDesktop extends StatelessWidget with _WelcomeDesktopMixin {
  _WelcomeDesktop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _WelcomeDrawer(drawerNotifier: drawerNotifier, viewKey: viewKey),
          const Expanded(child: Text('Desktop Body')),
        ],
      ),
    );
  }
}

mixin _WelcomeDesktopMixin {
  final drawerNotifier = GenericNotifier<DrawerMode>(DrawerMode.icon);
  final Key viewKey = const Key('_WelcomeTabletDrawer');
}
