part of 'regions_view.dart';

class RegionsBody {
  final RegionsViewModel viewModel;
  RegionsBody() : viewModel = RegionsViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Regions>>(
      valueListenable: viewModel.regions,
      builder: (context, regions, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (regions.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Bölge oluşturmak için tıklayınız',
                  child: context.myCard(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {
                      RegionsCreate(context: context, viewModel: viewModel)
                          .show();
                    },
                    child: const Icon(Icons.add),
                    width: 100,
                    height: 100,
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
    return ValueListenableBuilder(
      valueListenable: viewModel.regions,
      builder: (context, regions, _) {
        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding / 2,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: regions
              .map(
                (region) => context.myCard(
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  onTap: () {
                    viewModel.selectedRegion.value = region;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  context.mySubText(text: region.description),
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
                              text: '#${region.region}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.map,
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
    return ValueListenableBuilder<Regions?>(
      valueListenable: viewModel.selectedRegion,
      builder: (context, selectedRegion, _) {
        if (selectedRegion == null) {
          return const Center(child: Text('Lütfen bir bölge seçiniz'));
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
                      text: '#${selectedRegion.region}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  if (context.isMediumScreen || context.isLargeScreen)
                    context.mySubheadingText(text: 'Bölge Detayları'),
                  const Spacer(),
                  buildFooter(context),
                ],
              ),
              const Divider(),
              // Detaylar
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'İsim',
                        value: selectedRegion.description,
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.check_circle,
                        label: 'Durum',
                        value:
                            selectedRegion.isActive == true ? 'Aktif' : 'Pasif',
                        valueColor: selectedRegion.isActive == true
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
