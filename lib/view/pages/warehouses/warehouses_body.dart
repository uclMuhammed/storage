part of warehouses;

class WarehousesBody {
  final WarehousesViewModel viewModel;

  WarehousesBody(this.viewModel);

  Widget buildHeader(BuildContext context) {
    return FutureBuilder<List<IModel>>(
      future: viewModel.getAllWarehouses(),
      builder: (context, AsyncSnapshot<List<IModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        final warehouses = snapshot.data ?? [];
        if (warehouses.isEmpty) {
          return const Center(child: Text('Henüz depo bulunmuyor'));
        }

        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(horizontal: context.smallPadding / 2),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: warehouses
              .map(
                (warehouse) => context.myCard(
                  onTap: () {
                    viewModel.selectedWarehouseNotifier.value = warehouse;
                  },
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: context.mySubText(
                                text: (warehouse as Warehouses).description,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            context.myText(
                              text: '#${warehouse.warehouse}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.warehouse,
                              size: context.iconSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<Warehouses?>(
      valueListenable: viewModel.selectedWarehouseNotifier,
      builder: (context, selectedWarehouse, _) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.smallPadding),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.smallPadding,
                      vertical: context.smallPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(context.smallPadding),
                    ),
                    child: context.mySubheadingText(
                      text: '#${selectedWarehouse?.warehouse}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  context.mySubheadingText(text: 'Depo Detayları'),
                  const Spacer(),
                  if (context.isLargeScreen || context.isMediumScreen) ...[
                    buildFooter(context),
                  ]
                ],
              ),
              const Divider(),
              // Detaylar
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'İsim',
                        value: selectedWarehouse?.description ?? '',
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.location_on,
                        label: 'Adres',
                        value: selectedWarehouse?.address ?? '',
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.map,
                        label: 'Bölge',
                        value: selectedWarehouse?.regionId.toString() ?? '',
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.location_city,
                        label: 'Şehir',
                        value: selectedWarehouse?.cityId.toString() ?? '',
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.check_circle,
                        label: 'Durum',
                        value: selectedWarehouse?.isActive == true
                            ? 'Aktif'
                            : 'Pasif',
                        valueColor: selectedWarehouse?.isActive == true
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingAll(context.smallPadding),
        ).paddingAll(context.smallPadding);
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: context.iconSize),
        SizedBox(width: context.smallPadding / 2),
        Expanded(
          flex: 1,
          child: context.mySubText(
            text: '$label:',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 6,
          child: context.mySubText(
            text: value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: valueColor, fontSize: context.subTextSize),
          ),
        ),
      ],
    ).paddingVertical(context.smallPadding / 1.5);
  }

  Widget buildFooter(BuildContext context) {
    return ValueListenableBuilder<Warehouses?>(
      valueListenable: viewModel.selectedWarehouseNotifier,
      builder: (context, selectedWarehouse, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'delete',
              onPressed: () async {
                WarehousesDelete(
                  warehouse: selectedWarehouse!,
                  context: context,
                ).show();
              },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              heroTag: 'edit',
              onPressed: () {
                WarehousesEdit(
                  warehouse: selectedWarehouse!,
                  context: context,
                ).show();
              },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              heroTag: 'create',
              onPressed: () {
                WarehousesCreate(
                  context: context,
                ).show();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ).paddingAll(context.smallPadding);
      },
    );
  }
}
