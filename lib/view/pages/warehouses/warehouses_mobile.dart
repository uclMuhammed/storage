part of 'warehouses_view.dart';

class _WarehousesMobile extends StatelessWidget {
  final WarehousesViewModel viewModel;
  _WarehousesMobile() : viewModel = WarehousesViewModel()..init();

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
        Expanded(
          flex: 1,
          child: WarehousesBody(viewModel).buildFooter(context),
        ),
      ],
    );
  }
}
