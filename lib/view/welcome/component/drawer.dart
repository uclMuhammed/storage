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
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Get Started'),
        ),
      ],
    );
  }

  @override
  Widget buildDrawerHeader(BuildContext context) {
    return HeaderCard(parentKey: viewKey);
  }
}
