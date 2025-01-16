part of 'welcome_view.dart';

class _WelcomeMobile extends StatelessWidget with _WelcomeDrawerMixin {
  _WelcomeMobile();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _WelcomeDrawer(
        viewKey: drawerKey,
        drawerNotifier: drawerNotifier,
      ),
      appBar: const _WelcomeAppBar(),
      body: const Column(
        children: [
          Text('Welcome Mobile'),
        ],
      ),
    );
  }
}

mixin _WelcomeDrawerMixin {
  final drawerNotifier = GenericNotifier<DrawerMode>(DrawerMode.detail);
  final Key drawerKey = const Key('_WelcomeMobileDrawer');
}
