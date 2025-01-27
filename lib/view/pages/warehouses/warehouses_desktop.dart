part of 'warehouses_view.dart';

class _WarehousesDesktop extends StatelessWidget {
  final WarehousesViewModel viewModel;
  _WarehousesDesktop() : viewModel = WarehousesViewModel()..init();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: WarehousesBody(viewModel).buildHeader(context),
        ),
        Expanded(
          flex: 6,
          child: WarehousesBody(viewModel).buildBody(context),
        ),
      ],
    );
  }
}
