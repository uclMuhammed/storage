part of '../welcome_view.dart';

class _WelcomeDrawer extends BaseDrawerView {
  const _WelcomeDrawer({
    required super.drawerNotifier,
    required super.viewKey,
  });

  @override
  Widget buildDrawerBody(BuildContext context) {
    return const Column(
      children: [
        Text('Body'),
      ],
    );
  }

  @override
  Widget buildDrawerFooter(BuildContext context) {
    if (drawerNotifier.value == DrawerMode.icon) {
      return IconButton(onPressed: () {}, icon: const Icon(Icons.logout));
    }
    return ElevatedButton(
      onPressed: () {},
      child: const Row(
        spacing: 8,
        children: [Icon(Icons.logout), Text('Logout')],
      ),
    ).fittedBox;
  }

  @override
  Widget buildDrawerHeader(BuildContext context) {
    return const HeaderCard();
  }
}
