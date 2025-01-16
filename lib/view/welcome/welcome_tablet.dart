part of 'welcome_view.dart';

class _WelcomeTablet extends StatelessWidget with _WelcomeTabletMixin {
  _WelcomeTablet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _WelcomeDrawer(drawerNotifier: drawerNotifier, viewKey: viewKey),
          const Expanded(child: Text('Tablet Body')),
        ],
      ),
    );
  }
}

mixin _WelcomeTabletMixin {
  final drawerNotifier = GenericNotifier<DrawerMode>(DrawerMode.icon);
  final Key viewKey = const Key('_WelcomeTabletDrawer');
}
