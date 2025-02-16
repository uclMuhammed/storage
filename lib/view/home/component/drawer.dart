part of '../home_view.dart';

class _Drawer extends BaseDrawerView {
  final HomeViewModel viewModel;
  const _Drawer({
    required super.viewKey,
    required this.viewModel,
    required super.drawerNotifier,
  });

  @override
  Widget buildDrawerButton(BuildContext context) {
    return context.myShortCutButton(
      name: 'STOKLARIM.com',
      drawerMode: drawerNotifier.value,
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
          children: DrawerData.drawerModels
              .map(
                (e) => context.myShortCutButton(
                  name: e.title,
                  icon: e.icon,
                  drawerMode: drawerNotifier.value,
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
  Widget buildDrawerBody(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.drawerModels,
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: DrawerData.drawerModels
                .map(
                  (e) => context.myShortCutButton(
                    name: e.title,
                    icon: e.icon,
                    drawerMode: drawerNotifier.value,
                    onTap: () {
                      if (e.title == 'LOG OUT') {
                        _handleLogout(context);
                      } else {
                        viewModel.currentPage.value = e.page!;
                      }
                    },
                    tooltipMessage:
                        drawerNotifier.value == DrawerMode.icon ? e.title : '',
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget buildDrawerFooter(BuildContext context) {
    return context.myShortCutButton(
      drawerMode: drawerNotifier.value,
      name: 'Settings',
      icon: Icons.settings,
      onTap: () {
        viewModel.currentPage.value = const SettingsView();
      },
      tooltipMessage: drawerNotifier.value == DrawerMode.icon ? 'Settings' : '',
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    try {
      // Önce storage'ı temizle
      await ServiceAuthClient().logout();

      // RouteController üzerinden yönlendirme yap
      if (context.mounted) {
        routeController.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Routes.login.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      // Hata durumunda da aynı şekilde yönlendir
      if (context.mounted) {
        routeController.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          Routes.login.routeName,
          (route) => false,
        );
      }
    }
  }
}
