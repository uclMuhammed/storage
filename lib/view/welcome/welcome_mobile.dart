part of 'welcome_view.dart';

class _WelcomeMobile extends StatelessWidget with _WelcomeMobileMixin {
  _WelcomeMobile();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _WelcomeDrawer(
        viewKey: drawerKey,
        drawerNotifier: notifier,
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

mixin _WelcomeMobileMixin {
  final notifier = GenericNotifier<DrawerMode>(DrawerMode.detail);
  final Key drawerKey = const Key('_WelcomeMobileDrawer');
}
