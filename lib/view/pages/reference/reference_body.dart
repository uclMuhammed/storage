part of 'reference_view.dart';

class ReferenceBody {
  final ReferenceViewModel viewModel;
  ReferenceBody() : viewModel = ReferenceViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.references,
      builder: (context, references, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: viewModel.loadingNotifier,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (references.isEmpty) {
              return Center(
                child: Tooltip(
                  message: 'Referans oluşturmak için tıklayınız',
                  child: context.myCard(
                    onTap: () {
                      ReferenceCreate(
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
    return ValueListenableBuilder<List<ReferenceCode>>(
      valueListenable: viewModel.references,
      builder: (context, references, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: references
              .map(
                (r) => context.myCard(
                  onTap: () {
                    viewModel.selectedReference.value = r;
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
                              child: context.mySubText(text: r.description),
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
                              text: '#${r.id}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.inbox,
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
    return ValueListenableBuilder<ReferenceCode?>(
      valueListenable: viewModel.selectedReference,
      builder: (context, selectedReference, _) {
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
                      borderRadius: BorderRadius.circular(context.borderRadius),
                    ),
                    child: context.mySubheadingText(
                        text: '#${selectedReference?.id}'),
                  ),
                  SizedBox(width: context.smallPadding),
                  if (context.isMediumScreen || context.isLargeScreen)
                    context.mySubheadingText(text: 'Referans Detayları'),
                  buildFooter(context),
                ],
              ),
              const Divider(),
              //detaylar
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      context.bodyDetailRow(
                        context,
                        icon: Icons.description,
                        label: 'Referans Açıklaması',
                        value: selectedReference?.description ?? '',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.calendar_month,
                        label: 'Başlangıç Tarihi',
                        value: selectedReference?.startDate
                                .toString()
                                .replaceRange(10, null, '') ??
                            '',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.calendar_month,
                        label: 'Bitiş Tarihi',
                        value: selectedReference?.endDate
                                .toString()
                                .replaceRange(10, null, '') ??
                            '',
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
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Referans Sil',
            heroTag: 'delete',
            onPressed: () {
              ReferenceDelete(
                context: context,
                viewModel: viewModel,
                reference:
                    viewModel.selectedReference.value ?? ReferenceCode.empty(),
              ).show();
            },
            child: const Icon(Icons.delete),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            tooltip: 'Referans Düzenle',
            heroTag: 'edit',
            onPressed: () {
              ReferenceUpdate(
                context: context,
                viewModel: viewModel,
                reference:
                    viewModel.selectedReference.value ?? ReferenceCode.empty(),
              ).show();
            },
            child: const Icon(Icons.edit),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            tooltip: 'Referans Ekle',
            heroTag: 'add',
            onPressed: () {
              ReferenceCreate(
                context: context,
                viewModel: viewModel,
              ).show();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
