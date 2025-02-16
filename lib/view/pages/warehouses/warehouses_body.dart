part of 'warehouses_view.dart';

class WarehousesBody {
  final WarehousesViewModel viewModel;

  WarehousesBody() : viewModel = WarehousesViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Warehouses>>(
      valueListenable: viewModel.warehouses,
      builder: (context, warehouses, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (warehouses.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Depo oluşturmak için tıklayınız',
                  child: context.myCard(
                    onTap: () {
                      WarehousesCreate(
                        context: context,
                        viewModel: viewModel,
                      ).show();
                    },
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    width: 100,
                    height: 100,
                    child: const Icon(Icons.add),
                  ),
                ),
              );
            }

            if (viewModel.error.value != null) {
              return Center(child: Text(viewModel.error.value!));
            }

            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: buildHeader(context),
                ),
                Expanded(
                  flex: 3,
                  child: buildBody(context),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return ValueListenableBuilder<List<Warehouses>>(
      valueListenable: viewModel.warehouses,
      builder: (context, warehouses, _) {
        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding / 2,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: warehouses
              .map(
                (warehouse) => context.myCard(
                  onTap: () {
                    viewModel.selectedWarehouse.value = warehouse;
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
                                text: warehouse.description,
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
                              text: '#${warehouse.id}',
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
      valueListenable: viewModel.selectedWarehouse,
      builder: (context, selectedWarehouse, _) {
        if (selectedWarehouse == null) {
          return const Center(child: Text('Lütfen bir depo seçiniz'));
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.borderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.smallPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(context.borderRadius),
                    ),
                    child: context.mySubheadingText(
                      text: '#${selectedWarehouse.id}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  if (context.isMediumScreen || context.isLargeScreen)
                    context.mySubheadingText(text: 'Depo Detayları'),
                  const Spacer(),
                  buildFooter(context),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'İsim:',
                        value: selectedWarehouse.description,
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.location_on,
                        label: 'Adres:',
                        value: selectedWarehouse.address,
                      ),
                      ValueListenableBuilder<List<Regions>>(
                        valueListenable: viewModel.regions,
                        builder: (context, regions, _) {
                          final region = regions.firstWhere(
                            (region) => region.id == selectedWarehouse.regionId,
                            orElse: () => Regions.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.map,
                            label: 'Bölge:',
                            value: region.description,
                          );
                        },
                      ),
                      ValueListenableBuilder<List<Cities>>(
                        valueListenable: viewModel.cities,
                        builder: (context, cities, _) {
                          final city = cities.firstWhere(
                            (city) => city.id == selectedWarehouse.cityId,
                            orElse: () => Cities.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.location_city,
                            label: 'Şehir:',
                            value: city.description,
                          );
                        },
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

  Widget buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            WarehousesDelete(
              context: context,
              viewModel: viewModel,
              warehouse:
                  viewModel.selectedWarehouse.value ?? Warehouses.empty(),
            ).show();
          },
          tooltip: 'Depo Sil',
          heroTag: 'delete',
          child: const Icon(Icons.delete),
        ),
        SizedBox(width: context.smallPadding),
        FloatingActionButton(
          onPressed: () {
            WarehousesEdit(
              context: context,
              viewModel: viewModel,
              warehouse:
                  viewModel.selectedWarehouse.value ?? Warehouses.empty(),
            ).show();
          },
          tooltip: 'Depo Düzenle',
          heroTag: 'edit',
          child: const Icon(Icons.edit),
        ),
        SizedBox(width: context.smallPadding),
        FloatingActionButton(
          onPressed: () {
            WarehousesCreate(
              context: context,
              viewModel: viewModel,
            ).show();
          },
          tooltip: 'Depo Ekle',
          heroTag: 'add',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
