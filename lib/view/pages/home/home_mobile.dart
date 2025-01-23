part of 'home_view.dart';

class HomeMobile extends StatelessWidget {
  final HomeViewModel viewModel;
  late final HomeBody body;

  HomeMobile({super.key}) : viewModel = HomeViewModel() {
    body = HomeBody(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _HomeAppBar(viewModel: viewModel),
      drawer: _Drawer(
        viewModel: viewModel,
        drawerNotifier: viewModel.drawerNotifier,
        viewKey: viewModel.viewKey,
      ),
      body: body.buildBody(context),
    );
  }
}
