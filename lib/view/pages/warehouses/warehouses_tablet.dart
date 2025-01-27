part of warehouses;

class _WarehousesTablet extends StatelessWidget {
  final WarehousesViewModel viewModel;

  _WarehousesTablet() : viewModel = WarehousesViewModel()..init();

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
