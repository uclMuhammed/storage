part of 'product_movement_view.dart';

class ProductMovementBody {
  final ProductMovementViewModel viewModel;
  ProductMovementBody() : viewModel = ProductMovementViewModel()..init();

  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: viewModel.loadingNotifier,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
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
              child: buildBody(context).paddingAll(context.smallPadding),
            ),
          ],
        );
      },
    );
  }

  Widget buildHeader(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.productMovements,
      builder: (context, productMovements, _) {
        return context.responsiveGridView(
          padding: EdgeInsets.symmetric(
            horizontal: context.smallPadding / 2,
            vertical: context.smallPadding,
          ),
          crossAxisCount: 1,
          childAspectRatio: 0.75,
          children: productMovements
              .map(
                (p) => context.myCard(
                  onTap: () {
                    viewModel.selectedProductMovement.value = p;
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
                              child: context.mySubText(text: p.description),
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
                              text: '#${p.id}',
                              style: TextStyle(
                                fontSize: context.bodySize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.move_to_inbox,
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
    return ValueListenableBuilder(
      valueListenable: viewModel.selectedProductMovement,
      builder: (context, selectedProductMovement, _) {
        return Container(
          padding: EdgeInsets.all(context.smallPadding),
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
                        text: '#${selectedProductMovement?.id}'),
                  ),
                  SizedBox(width: context.smallPadding),
                  context.mySubText(
                      text: selectedProductMovement?.description ?? ''),
                  buildFooter(context),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ValueListenableBuilder<List<Warehouses>>(
                        valueListenable: viewModel.warehouses,
                        builder: (context, value, _) {
                          final warehouse = value.firstWhere(
                            (warehouse) =>
                                warehouse.id ==
                                selectedProductMovement?.warehouseId,
                            orElse: () => Warehouses.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.warehouse,
                            label: 'Depo',
                            value: warehouse.description,
                          );
                        },
                      ),
                      ValueListenableBuilder<List<Suppliers>>(
                        valueListenable: viewModel.suppliers,
                        builder: (context, value, _) {
                          final supplier = value.firstWhere(
                            (supplier) =>
                                supplier.id ==
                                selectedProductMovement?.supplierId,
                            orElse: () => Suppliers.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.person,
                            label: 'Tedarikçi',
                            value: supplier.name,
                          );
                        },
                      ),
                      ValueListenableBuilder<List<Products>>(
                        valueListenable: viewModel.products,
                        builder: (context, products, _) {
                          final product = products.firstWhere(
                            (product) =>
                                product.id ==
                                selectedProductMovement?.productId,
                            orElse: () => Products.empty(),
                          );

                          return context.bodyDetailRow(context,
                              icon: Icons.branding_watermark,
                              label: 'Ürün',
                              value: product.description);
                        },
                      ),
                      ValueListenableBuilder<List<ProjectCode>>(
                        valueListenable: viewModel.projects,
                        builder: (context, value, _) {
                          final project = value.firstWhere(
                            (project) =>
                                project.id ==
                                selectedProductMovement?.projectId,
                            orElse: () => ProjectCode.empty(),
                          );
                          return context.bodyDetailRow(context,
                              icon: Icons.business,
                              label: 'Proje',
                              value: project.description);
                        },
                      ),
                      ValueListenableBuilder<List<ReferenceCode>>(
                        valueListenable: viewModel.reference,
                        builder: (context, value, _) {
                          final reference = value.firstWhere(
                            (reference) =>
                                reference.id ==
                                selectedProductMovement?.referenceId,
                            orElse: () => ReferenceCode.empty(),
                          );
                          return context.bodyDetailRow(context,
                              icon: Icons.business,
                              label: 'Referans',
                              value: reference.description);
                        },
                      ),
                      ValueListenableBuilder<List<TaxRate>>(
                        valueListenable: viewModel.taxes,
                        builder: (context, value, _) {
                          final tax = value.firstWhere(
                            (tax) => tax.id == selectedProductMovement?.taxId,
                            orElse: () => TaxRate.empty(),
                          );
                          return context.bodyDetailRow(
                            context,
                            icon: Icons.business,
                            label: 'Vergi',
                            value: tax.description,
                          );
                        },
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.business,
                        label: 'Miktar',
                        value:
                            selectedProductMovement?.quantity.toString() ?? '0',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.business,
                        label: 'Fiyat',
                        value: selectedProductMovement?.price.toString() ?? '0',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.calendar_month,
                        label: 'İşlem Tarihi',
                        value: selectedProductMovement?.transactionDate
                                .toString()
                                .replaceRange(10, null, '') ??
                            '',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.edit_document,
                        label: 'Belge No',
                        value: selectedProductMovement?.documentNo ?? '',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.business,
                        label: 'İade',
                        value: selectedProductMovement?.isReturn == true
                            ? 'Evet'
                            : 'Hayır',
                      ),
                      context.bodyDetailRow(
                        context,
                        icon: Icons.business,
                        label: 'Alım Satım',
                        value: selectedProductMovement?.isPurchases == true
                            ? 'Alım'
                            : 'Satım',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFooter(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Ürün Hareketi Sil',
            heroTag: 'delete',
            onPressed: () {
              viewModel.deleteProductMovement(125);
            },
            child: const Icon(Icons.delete),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            tooltip: 'Ürün Hareketi Güncelle',
            heroTag: 'edit',
            onPressed: () {
              ProductMovementUpdate(
                context: context,
                viewModel: viewModel,
              ).show();
            },
            child: const Icon(Icons.edit),
          ),
          SizedBox(width: context.smallPadding),
          FloatingActionButton(
            tooltip: 'Ürün Hareketi Oluştur',
            heroTag: 'add',
            onPressed: () {
              ProductMovementCreate(
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
