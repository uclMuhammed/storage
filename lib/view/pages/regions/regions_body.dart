part of regions;

class RegionsBody extends BaseBody {
  final RegionsViewModel viewModel;
  RegionsBody({
    required this.viewModel,
  });

  @override
  Widget buildHeader(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.refreshTrigger,
      builder: (context, _, __) {
        return FutureBuilder<List<IModel>>(
          future: viewModel.getAllRegions(),
          builder: (context, AsyncSnapshot<List<IModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            final regions = snapshot.data ?? [];
            if (regions.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Bölge oluşturmak için tıklayınız',
                  child: context.myCard(
                    onTap: () {
                      RegionsCreate(context: context, viewModel: viewModel)
                          .show();
                    },
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
              children: regions
                  .map(
                    (regions) => context.myCard(
                      onTap: () {
                        viewModel.selectedRegion.value = regions as Regions?;
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
                                    text: (regions as Regions).description,
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
                                  text: '#${(regions as Regions).region}',
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
      },
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.refreshTrigger,
      builder: (context, value, child) {
        return ValueListenableBuilder<Regions?>(
          valueListenable: viewModel.selectedRegion,
          builder: (context, selectedRegion, _) {
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
                          text: '#${selectedRegion?.region}',
                        ),
                      ),
                      SizedBox(width: context.smallPadding),
                      context.mySubheadingText(text: 'Bölge Detayları'),
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
                            value: selectedRegion?.description ?? '',
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.check_circle,
                            label: 'Durum',
                            value: selectedRegion?.isActive == true
                                ? 'Aktif'
                                : 'Pasif',
                            valueColor: selectedRegion?.isActive == true
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
          child: context.mySubText(text: '$label:'),
        ),
        Expanded(
          flex: 6,
          child: context.mySubText(
            text: value,
            style: TextStyle(color: valueColor, fontSize: context.subTextSize),
          ),
        ),
      ],
    ).paddingVertical(context.smallPadding / 1.5);
  }

  @override
  Widget buildFooter(BuildContext context) {
    return ValueListenableBuilder<Regions?>(
      valueListenable: viewModel.selectedRegion,
      builder: (context, selectedRegion, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              tooltip: 'Bölge Sil',
              heroTag: 'delete',
              onPressed: () {
                RegionsDelete(
                  context: context,
                  viewModel: viewModel,
                  region: selectedRegion!,
                ).show();
              },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Bölge Düzenle',
              heroTag: 'edit',
              onPressed: () {
                RegionsEdit(
                  context: context,
                  viewModel: viewModel,
                  region: selectedRegion!,
                ).show();
              },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Bölge Oluştur',
              heroTag: 'create',
              onPressed: () {
                RegionsCreate(
                  context: context,
                  viewModel: viewModel,
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
