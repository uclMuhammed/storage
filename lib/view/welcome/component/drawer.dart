part of '../welcome_view.dart';

class _WelcomeDrawer extends BaseDrawer {
  final Key drawerKey;
  const _WelcomeDrawer({required this.drawerKey}) : super(key: drawerKey);

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
    return HeaderCard(parentKey: drawerKey);
  }
}
