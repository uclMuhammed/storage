part of 'home_view.dart';

class HomeDesktop extends StatelessWidget {
  final HomeViewModel viewModel;
  late final HomeBody body;

  HomeDesktop({super.key}) : viewModel = HomeViewModel() {
    body = HomeBody(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    viewModel.drawerNotifier.change(DrawerMode.detail);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return Scaffold(
          body: Row(
            children: [
              _Drawer(
                viewModel: viewModel,
                drawerNotifier: viewModel.drawerNotifier,
                viewKey: viewModel.viewKey,
              ),
              Expanded(
                child: Column(
                  children: [
                    _HomeAppBar(viewModel: viewModel),
                    Expanded(
                      child: body.buildBody(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
