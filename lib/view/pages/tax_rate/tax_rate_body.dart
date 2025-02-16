part of 'tax_rate_view.dart';

class TaxRateBody {
  final TaxRateViewModel viewModel;
  TaxRateBody() : viewModel = TaxRateViewModel()..init();
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.taxRates,
      builder: (context, taxRates, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.error.value != null) {
              return Center(child: Text(viewModel.error.value!));
            }

            if (taxRates.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Vergi oranı oluşturmak için tıklayınız',
                  child: context.myCard(
                    onTap: () {
                      TaxRateCreate(
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
    return ValueListenableBuilder<List<TaxRate>>(
      valueListenable: viewModel.taxRates,
      builder: (context, taxRates, child) {
        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: taxRates
              .map(
                (e) => context.myCard(
                  onTap: () {
                    viewModel.selectedTaxRate.value = e;
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
                              child: context.mySmallText(text: e.description),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            context.mySmallText(
                              text: '#${e.id}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.attach_money,
                              size: context.iconSize,
                            ),
                          ],
                        ),
                      )
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
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.refreshTrigger,
      builder: (context, refreshTrigger, child) {
        return ValueListenableBuilder<TaxRate?>(
          valueListenable: viewModel.selectedTaxRate,
          builder: (context, selectedTaxRate, _) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(context.borderRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //başlık
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.smallPadding),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius:
                              BorderRadius.circular(context.borderRadius),
                        ),
                        child: context.mySubheadingText(
                            text: '#${selectedTaxRate?.id}'),
                      ),
                      SizedBox(width: context.smallPadding),
                      if (context.isLargeScreen || context.isMediumScreen)
                        context.mySubheadingText(text: 'Vergi Oranı Detayları'),
                      const Spacer(),
                      buildFooter(context),
                    ],
                  ),
                  const Divider(),
                  //detaylar
                  if (refreshTrigger)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            context.bodyDetailRow(context,
                                icon: Icons.description,
                                label: 'Vergi Adı',
                                value: selectedTaxRate?.description ?? ''),
                            context.bodyDetailRow(context,
                                icon: Icons.attach_money,
                                label: 'Vergi Oranı',
                                value: selectedTaxRate?.tax.toString() ?? ''),
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

  Widget buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          tooltip: 'Vergi Sil',
          heroTag: 'delete',
          onPressed: () {
            TaxRateDelete(
              context: context,
              viewModel: viewModel,
              taxRate: viewModel.selectedTaxRate.value ?? TaxRate.empty(),
            ).show(context);
          },
          child: const Icon(Icons.delete),
        ),
        SizedBox(width: context.smallPadding),
        FloatingActionButton(
          tooltip: 'Vergi Düzenle',
          heroTag: 'edit',
          onPressed: () {
            TaxRateUpdate(
              context: context,
              viewModel: viewModel,
              taxRate: viewModel.selectedTaxRate.value ?? TaxRate.empty(),
            ).show();
          },
          child: const Icon(Icons.edit),
        ),
        SizedBox(width: context.smallPadding),
        FloatingActionButton(
          tooltip: 'Vergi Ekle',
          heroTag: 'add',
          onPressed: () {
            TaxRateCreate(
              context: context,
              viewModel: viewModel,
            ).show();
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
