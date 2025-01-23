part of '../home_view.dart';

class _Drawer extends BaseDrawerView {
  final HomeViewModel viewModel;
  const _Drawer({
    required super.viewKey,
    required this.viewModel,
    required super.drawerNotifier,
    // ignore: unused_element
    super.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  });

  @override
  Widget buildDrawerButton(BuildContext context) {
    return context.myShortCutButton(
      name: 'STOKLARIM.com',
      icon: Icons.menu,
      onTap: () {
        drawerNotifier.change(
          drawerNotifier.value == DrawerMode.icon
              ? DrawerMode.detail
              : DrawerMode.icon,
        );
      },
    );
  }

  @override
  Widget buildDrawerHeader(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.drawerModels,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: DrawerData.reportDrawerModels
              .map(
                (e) => context.myShortCutButton(
                  name: e.title,
                  icon: e.icon,
                  onTap: () {
                    viewModel.currentPage.value = e.page!;
                  },
                  tooltipMessage:
                      drawerNotifier.value == DrawerMode.icon ? e.title : '',
                ),
              )
              .toList(),
        );
        ;
      },
    );
  }

  @override
  Widget buildDrawerBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.drawerModels,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: DrawerData.drawerModels
              .map(
                (e) => context.myShortCutButton(
                  name: e.title,
                  icon: e.icon,
                  onTap: () {
                    viewModel.currentPage.value = e.page!;
                  },
                  tooltipMessage:
                      drawerNotifier.value == DrawerMode.icon ? e.title : '',
                ),
              )
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildDrawerFooter(BuildContext context) {
    return context.myShortCutButton(
      name: 'Settings',
      icon: Icons.settings,
      onTap: () {},
      tooltipMessage: drawerNotifier.value == DrawerMode.icon ? 'Settings' : '',
    );
  }
}
