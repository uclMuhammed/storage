part of 'brands_view.dart';

class BrandsBody {
  final BrandsViewModel viewModel;
  BrandsBody() : viewModel = BrandsViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Brands>>(
      valueListenable: viewModel.brands,
      builder: (context, brands, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (brands.isEmpty) {
              return buildNullBody(context);
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
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (BuildContext context, bool isLoading, Widget? child) {
        return ValueListenableBuilder<List<Brands>>(
          valueListenable: viewModel.brands,
          builder: (context, brands, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return context.responsiveGridView(
              padding: EdgeInsets.symmetric(
                horizontal: context.smallPadding / 2,
                vertical: context.smallPadding,
              ),
              crossAxisCount: 1,
              childAspectRatio: 0.75,
              children: brands
                  .map(
                    (brand) => context.myCard(
                      onTap: () {
                        viewModel.selectedBrand.value = brand;
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
                                    text: brand.description,
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
                                  text: '#${brand.id}',
                                  style: TextStyle(
                                    fontSize: context.bodySize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.branding_watermark,
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
    return ValueListenableBuilder<Brands?>(
      valueListenable: viewModel.selectedBrand,
      builder: (context, selectedBrand, _) {
        if (selectedBrand == null) {
          return const Center(child: Text('Lütfen bir marka seçiniz'));
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
                      text: '#${selectedBrand.brand}',
                    ),
                  ),
                  SizedBox(width: context.smallPadding),
                  context.mySubheadingText(text: 'Marka Detayları'),
                  const Spacer(),
                  if (context.isLargeScreen || context.isMediumScreen) ...[
                    buildFooter(context),
                  ]
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'İsim',
                        value: selectedBrand.description,
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.check_circle,
                        label: 'Durum',
                        value:
                            selectedBrand.isActive == true ? 'Aktif' : 'Pasif',
                        valueColor: selectedBrand.isActive == true
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
    return ValueListenableBuilder<Brands?>(
      valueListenable: viewModel.selectedBrand,
      builder: (context, selectedBrand, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              tooltip: 'Marka Sil',
              heroTag: 'delete',
              onPressed: () {
                BrandsDelete(
                  context: context,
                  viewModel: viewModel,
                  brand: selectedBrand!,
                ).show();
              },
              child: const Icon(Icons.delete),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Marka Düzenle',
              heroTag: 'edit',
              onPressed: () {
                BrandsEdit(
                  context: context,
                  viewModel: viewModel,
                  brand: selectedBrand!,
                ).show();
              },
              child: const Icon(Icons.edit),
            ),
            SizedBox(width: context.smallPadding),
            FloatingActionButton(
              tooltip: 'Marka Oluştur',
              heroTag: 'create',
              onPressed: () {
                BrandsCreate(
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

  Widget buildNullBody(BuildContext context) {
    return Center(
      child: Tooltip(
        message: 'Marka oluşturmak için tıklayınız',
        child: context.myCard(
          onTap: () {
            BrandsCreate(
              context: context,
              viewModel: viewModel,
            ).show();
          },
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          width: 100,
          height: 100,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
