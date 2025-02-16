part of 'unit_view.dart';

class UnitBody {
  final UnitViewModel viewModel;
  UnitBody() : viewModel = UnitViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ProductUnits>>(
      valueListenable: viewModel.units,
      builder: (context, units, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (viewModel.error.value != null) {
              return Center(
                child: Text(viewModel.error.value!),
              );
            }

            if (units.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Birim oluşturmak için tıklayınız',
                  child: context.myCard(
                    onTap: () =>
                        UnitCreate(context: context, viewModel: viewModel),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    width: 100,
                    height: 100,
                    child: const Icon(Icons.add),
                  ),
                ),
              );
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
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (context, _, __) {
        return ValueListenableBuilder<List<ProductUnits>>(
          valueListenable: viewModel.units,
          builder: (context, units, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (units.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Birim oluşturmak için tıklayınız',
                  child: context.myCard(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {
                      UnitCreate(
                        context: context,
                        viewModel: viewModel,
                      ).show();
                    },
                    width: 100,
                    height: 100,
                    child: const Icon(Icons.add),
                  ),
                ),
              );
            }

            return context.responsiveGridView(
              padding: EdgeInsets.symmetric(
                horizontal: context.smallPadding / 2,
                vertical: context.smallPadding,
              ),
              crossAxisCount: 1,
              childAspectRatio: 0.75,
              children: units
                  .map(
                    (unit) => context.myCard(
                      onTap: () {
                        viewModel.selectedUnit.value = unit;
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
                                    overflow: TextOverflow.ellipsis,
                                    text: unit.description,
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
                                  text: '#${unit.unit}',
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: context.bodySize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.scale,
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
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (context, value, child) {
        return ValueListenableBuilder<ProductUnits?>(
          valueListenable: viewModel.selectedUnit,
          builder: (context, selectedUnit, _) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(context.borderRadius),
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
                          borderRadius:
                              BorderRadius.circular(context.borderRadius),
                        ),
                        child: context.mySubheadingText(
                          text: '#${selectedUnit?.unit}',
                        ),
                      ),
                      SizedBox(width: context.smallPadding),
                      if (context.isLargeScreen || context.isMediumScreen)
                        context.mySubheadingText(text: 'Birim Detayları'),
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
                            label: 'Açıklama',
                            value: selectedUnit?.description ?? '',
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.scale,
                            label: 'Miktar',
                            value: selectedUnit?.quantity.toString() ?? '',
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
        Icon(
          icon,
          size: context.iconSize,
        ),
        SizedBox(width: context.smallPadding / 2),
        Expanded(
          flex: 1,
          child: context.mySubText(text: '$label:'),
        ),
        Expanded(
          flex: 4,
          child: context.mySubText(
            text: value,
            style: TextStyle(
              color: valueColor,
              fontSize: context.subTextSize,
            ),
          ),
        ),
      ],
    ).paddingVertical(context.smallPadding / 1.5);
  }

  Widget buildFooter(BuildContext context) {
    return ValueListenableBuilder<ProductUnits?>(
      valueListenable: viewModel.selectedUnit,
      builder: (context, selectedUnit, _) {
        return Row(
          children: [
            FloatingActionButton(
              tooltip: 'Birim Sil',
              heroTag: 'delete',
              onPressed: () {
                UnitDelete(
                  unit: selectedUnit!,
                  context: context,
                  viewModel: viewModel,
                ).show();
              },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Birim Düzenle',
              heroTag: 'edit',
              onPressed: () {
                UnitUpdate(
                  unit: selectedUnit!,
                  context: context,
                  viewModel: viewModel,
                ).show();
              },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Birim Oluştur',
              heroTag: 'create',
              onPressed: () {
                UnitCreate(
                  context: context,
                  viewModel: viewModel,
                ).show();
              },
              child: const Icon(Icons.add),
            ),
          ],
        );
      },
    );
  }
}
