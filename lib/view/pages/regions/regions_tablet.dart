part of 'regions_view.dart';

class _RegionsTablet extends StatelessWidget {
  final RegionsViewModel viewModel;
  _RegionsTablet() : viewModel = RegionsViewModel()..init();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: RegionsBody(viewModel: viewModel).buildHeader(context),
        ),
        Expanded(
          flex: 6,
          child: RegionsBody(viewModel: viewModel).buildBody(context),
        ),
      ],
    );
  }
}
