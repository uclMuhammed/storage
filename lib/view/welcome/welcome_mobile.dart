part of 'welcome_view.dart';

class _WelcomeMobile extends StatelessWidget {
  const _WelcomeMobile();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: _WelcomeDrawer(drawerKey: Key('_WelcomeMobileDrawer')),
      appBar: _WelcomeAppBar(),
      body: Column(
        children: [
          Text('Welcome Mobile'),
        ],
      ),
    );
  }
}
