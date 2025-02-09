part of 'suppliers_view.dart';

class SuppliersBody {
  final SuppliersViewModel viewModel;
  SuppliersBody() : viewModel = SuppliersViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (BuildContext context, bool isLoading, Widget? child) {
        return ValueListenableBuilder<List<Suppliers>>(
          valueListenable: viewModel.suppliers,
          builder: (context, suppliers, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.error.value != null) {
              return Center(child: Text(viewModel.error.value!));
            }

            if (suppliers.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Tedarikçi oluşturmak için tıklayınız',
                  child: context.myCard(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {
                      SuppliersCreate(
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
      valueListenable: viewModel.refreshTrigger,
      builder: (context, _, __) {
        return ValueListenableBuilder<List<Suppliers>>(
          valueListenable: viewModel.suppliers,
          builder: (context, suppliers, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (suppliers.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Tedarikçi oluşturmak için tıklayınız',
                  child: context.myCard(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {
                      SuppliersCreate(
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
              children: suppliers
                  .map(
                    (supplier) => context.myCard(
                      onTap: () {
                        viewModel.selectedSupplier.value = supplier;
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
                                    text: supplier.name,
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
                                  text: '#${supplier.supplier}',
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: context.bodySize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.person,
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
    return ValueListenableBuilder<Suppliers?>(
      valueListenable: viewModel.selectedSupplier,
      builder: (context, selectedSupplier, _) {
        if (selectedSupplier == null) {
          return const Center(child: Text('Lütfen bir tedarikçi seçiniz'));
        }
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
                      borderRadius: BorderRadius.circular(context.borderRadius),
                    ),
                    child: context.mySubheadingText(
                      text: '#${selectedSupplier.supplier}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  context.mySubheadingText(text: 'Tedarikçi Detayları'),
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
                        icon: Icons.person,
                        label: 'Adı',
                        value: selectedSupplier.name,
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.perm_identity,
                        label: 'Vergi No',
                        value: selectedSupplier.identityNo,
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.email,
                        label: 'Email',
                        value: selectedSupplier.email,
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.phone,
                        label: 'Telefon',
                        value: selectedSupplier.phone,
                      ),
                      _buildDetailRow(
                        context,
                        icon: Icons.location_on,
                        label: 'Adres',
                        value: selectedSupplier.address,
                      ),
                      ValueListenableBuilder(
                        valueListenable: viewModel.regions,
                        builder: (context, regions, _) {
                          final region = regions.firstWhere(
                            (region) => region.id == selectedSupplier.regionId,
                            orElse: () => Regions.empty(),
                          );
                          return _buildDetailRow(
                            context,
                            icon: Icons.location_on,
                            label: 'Bölge',
                            value: region.description,
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
          flex: 6,
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
    return ValueListenableBuilder<Suppliers?>(
      valueListenable: viewModel.selectedSupplier,
      builder: (context, selectedSupplier, _) {
        return Row(
          children: [
            FloatingActionButton(
              tooltip: 'Tedarikçi Sil',
              heroTag: 'delete',
              onPressed: () {
                SuppliersDelete(
                  supplier: selectedSupplier!,
                  context: context,
                  viewModel: viewModel,
                ).show();
              },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Tedarikçi Düzenle',
              heroTag: 'edit',
              onPressed: () {
                SuppliersEdit(
                  supplier: selectedSupplier!,
                  context: context,
                  viewModel: viewModel,
                ).show();
              },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Tedarikçi Detayları',
              heroTag: 'create',
              onPressed: () {
                SuppliersCreate(
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
