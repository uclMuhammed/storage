part of 'home_view.dart';

class HomeBody {
  final HomeViewModel viewModel;

  HomeBody({required this.viewModel});

  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<Widget>(
      valueListenable: viewModel.currentPage,
      builder: (context, page, _) {
        return page;
      },
    );
  }
}
