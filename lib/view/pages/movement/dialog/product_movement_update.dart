part of '../product_movement_view.dart';

class ProductMovementUpdate {
  final BuildContext context;
  final ProductMovementViewModel viewModel;

  ProductMovementUpdate({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController = TextEditingController(
        text: viewModel.selectedProductMovement.value?.description);
    final quantityController = TextEditingController(
        text: viewModel.selectedProductMovement.value?.quantity.toString());
    final priceController = TextEditingController(
        text: viewModel.selectedProductMovement.value?.price.toString());
    final transactionDateController = TextEditingController(
        text: viewModel.selectedProductMovement.value?.transactionDate
            .toString());
    final documentNoController = TextEditingController(
        text: viewModel.selectedProductMovement.value?.documentNo);

    var selectedWarehouseId = ValueNotifier(
      viewModel.selectedProductMovement.value?.warehouseId,
    );
    var selectedSupplierId = ValueNotifier(
      viewModel.selectedProductMovement.value?.supplierId,
    );
    var selectedProductId = ValueNotifier(
      viewModel.selectedProductMovement.value?.productId,
    );
    var selectedProjectCodeId = ValueNotifier(
      viewModel.selectedProductMovement.value?.projectId,
    );
    var selectedReferenceCodeId = ValueNotifier(
      viewModel.selectedProductMovement.value?.referenceId,
    );
    var selectedTaxRateId = ValueNotifier(
      viewModel.selectedProductMovement.value?.taxId,
    );

    ValueNotifier<bool> isReturn = ValueNotifier(
        viewModel.selectedProductMovement.value?.isReturn ?? false);
    ValueNotifier<bool> isPurchases = ValueNotifier(
        viewModel.selectedProductMovement.value?.isPurchases ?? false);

    Future<void> datePicker(TextEditingController controller) async {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2077),
      );
      if (date != null) {
        controller.text = date.toString().replaceRange(10, null, '');
      }
    }

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, size) {
            return AlertDialog(
              title: const Text('Ürün Hareketi Güncelle'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context
                          .myTextFormField(
                            labelText: 'Başlık',
                            controller: descriptionController,
                          )
                          .paddingBottom(context.smallPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                context.myText(text: 'Ürün Bilgileri'),
                                const Divider(),
                                ValueListenableBuilder<List<Warehouses>>(
                                  valueListenable: viewModel.warehouses,
                                  builder: (context, value, _) {
                                    return context
                                        .myDropdownButtonFormField<Warehouses>(
                                          labelText: 'Depo',
                                          style: context.smallTextStyle,
                                          items: value
                                              .map((e) =>
                                                  DropdownMenuItem<Warehouses>(
                                                    value: e,
                                                    child: Text(e.description),
                                                  ))
                                              .toList(),
                                          value: value.firstWhere(
                                            (element) =>
                                                element.id ==
                                                selectedWarehouseId.value,
                                            orElse: () => value.first,
                                          ),
                                          onChanged: (value) {
                                            selectedWarehouseId = value?.id
                                                as ValueNotifier<int?>;
                                          },
                                        )
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                                ValueListenableBuilder<List<Suppliers>>(
                                  valueListenable: viewModel.suppliers,
                                  builder: (BuildContext context,
                                      List<Suppliers> value, Widget? child) {
                                    return context
                                        .myDropdownButtonFormField<Suppliers>(
                                          labelText: 'Tedarikçi',
                                          style: context.smallTextStyle,
                                          items: value
                                              .map((e) =>
                                                  DropdownMenuItem<Suppliers>(
                                                    value: e,
                                                    child: Text(e.name),
                                                  ))
                                              .toList(),
                                          value: value.firstWhere(
                                            (element) =>
                                                element.id ==
                                                selectedSupplierId.value,
                                            orElse: () => value.first,
                                          ),
                                          onChanged: (value) {
                                            selectedSupplierId = value?.id
                                                as ValueNotifier<int?>;
                                          },
                                        )
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                                ValueListenableBuilder<List<Products>>(
                                  valueListenable: viewModel.products,
                                  builder: (context, products, _) {
                                    return context
                                        .myDropdownButtonFormField<Products>(
                                          labelText: 'Ürün',
                                          style: context.smallTextStyle,
                                          items: products
                                              .map((e) =>
                                                  DropdownMenuItem<Products>(
                                                    value: e,
                                                    child: Text(e.description),
                                                  ))
                                              .toList(),
                                          value: products.firstWhere(
                                            (element) =>
                                                element.id ==
                                                selectedProductId.value,
                                            orElse: () => products.first,
                                          ),
                                          onChanged: (value) {
                                            selectedProductId = value?.id
                                                as ValueNotifier<int?>;
                                          },
                                        )
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                                ValueListenableBuilder<List<ProjectCode>>(
                                  valueListenable: viewModel.projects,
                                  builder: (context, projectCodes, _) {
                                    return context
                                        .myDropdownButtonFormField<ProjectCode>(
                                          labelText: 'Proje Kodu',
                                          style: context.smallTextStyle,
                                          items: projectCodes
                                              .map((e) =>
                                                  DropdownMenuItem<ProjectCode>(
                                                    value: e,
                                                    child: Text(e.description),
                                                  ))
                                              .toList(),
                                          value: projectCodes.firstWhere(
                                            (element) =>
                                                element.id ==
                                                selectedProjectCodeId.value,
                                            orElse: () => projectCodes.first,
                                          ),
                                          onChanged: (value) {
                                            selectedProjectCodeId = value?.id
                                                as ValueNotifier<int?>;
                                          },
                                        )
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                                ValueListenableBuilder<List<ReferenceCode>>(
                                  valueListenable: viewModel.reference,
                                  builder: (context, referenceCodes, _) {
                                    return context
                                        .myDropdownButtonFormField<
                                            ReferenceCode>(
                                          labelText: 'Referans Kodu',
                                          style: context.smallTextStyle,
                                          items: referenceCodes
                                              .map((e) => DropdownMenuItem<
                                                      ReferenceCode>(
                                                    value: e,
                                                    child: Text(e.description),
                                                  ))
                                              .toList(),
                                          value: referenceCodes.firstWhere(
                                            (element) =>
                                                element.id ==
                                                selectedReferenceCodeId.value,
                                            orElse: () => referenceCodes.first,
                                          ),
                                          onChanged: (value) {
                                            selectedReferenceCodeId = value?.id
                                                as ValueNotifier<int?>;
                                          },
                                        )
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                                ValueListenableBuilder<List<TaxRate>>(
                                  valueListenable: viewModel.taxes,
                                  builder: (context, value, _) {
                                    return context
                                        .myDropdownButtonFormField<TaxRate>(
                                          labelText: 'Vergi Oranı',
                                          style: context.smallTextStyle,
                                          items: value
                                              .map((e) =>
                                                  DropdownMenuItem<TaxRate>(
                                                    value: e,
                                                    child: Text(e.description),
                                                  ))
                                              .toList(),
                                          value: value.firstWhere(
                                            (element) =>
                                                element.id ==
                                                selectedTaxRateId.value,
                                            orElse: () => value.first,
                                          ),
                                          onChanged: (TaxRate? value) {
                                            selectedTaxRateId.value = value?.id;
                                          },
                                        )
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: context.smallPadding,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                context.myText(text: 'İşlem Bilgileri'),
                                const Divider(),
                                context
                                    .myTextFormField(
                                      labelText: 'Fiyat',
                                      style: context.smallTextStyle,
                                      controller: priceController,
                                    )
                                    .paddingBottom(context.smallPadding),
                                context
                                    .myTextFormField(
                                      labelText: 'Miktar',
                                      style: context.smallTextStyle,
                                      controller: quantityController,
                                    )
                                    .paddingBottom(context.smallPadding),
                                context
                                    .myTextFormField(
                                      labelText: 'Tarih',
                                      hintText: 'yyyy-mm-dd',
                                      style: context.smallTextStyle,
                                      controller: transactionDateController,
                                      suffixIcon: IconButton(
                                        onPressed: () => datePicker(
                                            transactionDateController),
                                        icon: const Icon(Icons.calendar_month),
                                      ),
                                    )
                                    .paddingBottom(context.smallPadding),
                                context
                                    .myTextFormField(
                                      labelText: 'Belge No',
                                      style: context.smallTextStyle,
                                      controller: documentNoController,
                                    )
                                    .paddingBottom(context.smallPadding),
                                ValueListenableBuilder(
                                  valueListenable: isReturn,
                                  builder: (BuildContext context, dynamic value,
                                      Widget? child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        context
                                            .myText(text: 'İade:')
                                            .paddingHorizontal(
                                                context.smallPadding / 2),
                                        const Spacer(),
                                        Checkbox(
                                          value: isReturn.value,
                                          onChanged: (value) {
                                            isReturn.value = value ?? false;
                                          },
                                        ),
                                      ],
                                    )
                                        .paddingVertical(
                                            context.smallPadding / 2)
                                        .paddingBottom(context.smallPadding);
                                  },
                                ),
                                ValueListenableBuilder(
                                  valueListenable: isPurchases,
                                  builder: (BuildContext context, dynamic value,
                                      Widget? child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        context
                                            .myText(text: 'Alım:')
                                            .paddingHorizontal(
                                                context.smallPadding / 2),
                                        const Spacer(),
                                        Checkbox(
                                          value: isPurchases.value,
                                          onChanged: (value) {
                                            isPurchases.value = value ?? false;
                                          },
                                        ),
                                      ],
                                    ).paddingVertical(context.smallPadding / 2);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('İptal'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      try {
                        viewModel.updateProductMovement(
                          viewModel.selectedProductMovement.value!.id!,
                          selectedWarehouseId.value!,
                          selectedSupplierId.value!,
                          selectedProductId.value!,
                          int.parse(priceController.text.trim()),
                          double.parse(quantityController.text.trim()),
                          selectedTaxRateId.value!,
                          DateTime.parse(transactionDateController.text.trim()),
                          documentNoController.text.trim(),
                          descriptionController.text.trim(),
                          selectedProjectCodeId.value!,
                          selectedReferenceCodeId.value!,
                          isPurchases.value,
                          isReturn.value,
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        viewModel.error.value = e.toString();
                      }
                    }
                  },
                  child: const Text('Kaydet'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
