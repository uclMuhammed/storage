part of '../product_movement_view.dart';

class ProductMovementCreate {
  final BuildContext context;
  final ProductMovementViewModel viewModel;

  ProductMovementCreate({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController = TextEditingController();
    final quantityController = TextEditingController();
    final priceController = TextEditingController();
    final transactionDateController = TextEditingController();
    final documentNoController = TextEditingController();
    int? selectedWarehouseId;
    int? selectedSupplierId;
    int? selectedProductId;
    int? selectedProjectCodeId;
    int? selectedReferenceCodeId;
    int? selectedTaxRateId;
    String? selectedWarehouseName;
    ValueNotifier<bool> isReturn = ValueNotifier(false);
    ValueNotifier<bool> isPurchases = ValueNotifier(false);

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
        return AlertDialog(
          title: const Text('Ürün Hareketi Oluştur'),
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
                              builder: (BuildContext context,
                                  List<Warehouses> value, Widget? child) {
                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Depo',
                                      style: context.smallTextStyle,
                                      items: value
                                          .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.description),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        selectedWarehouseId =
                                            int.parse(value ?? '0');
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
                                    .myDropdownButtonFormField(
                                      labelText: 'Tedarikçi',
                                      style: context.smallTextStyle,
                                      items: value
                                          .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.name),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        selectedSupplierId =
                                            int.parse(value ?? '0');
                                      },
                                    )
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            ValueListenableBuilder<List<Products>>(
                              valueListenable: viewModel.products,
                              builder: (context, products, _) {
                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Ürün',
                                      style: context.smallTextStyle,
                                      items: products
                                          .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.description),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        selectedProductId =
                                            int.parse(value ?? '0');
                                      },
                                    )
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            ValueListenableBuilder<List<ProjectCode>>(
                              valueListenable: viewModel.projects,
                              builder: (context, projectCodes, _) {
                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Proje Kodu',
                                      style: context.smallTextStyle,
                                      items: projectCodes
                                          .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.description),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        selectedProjectCodeId =
                                            int.parse(value ?? '0');
                                      },
                                    )
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            ValueListenableBuilder<List<ReferenceCode>>(
                              valueListenable: viewModel.reference,
                              builder: (context, referenceCodes, _) {
                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Referans Kodu',
                                      style: context.smallTextStyle,
                                      items: referenceCodes
                                          .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.description),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        selectedReferenceCodeId =
                                            int.parse(value ?? '0');
                                      },
                                    )
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            ValueListenableBuilder<List<TaxRate>>(
                              valueListenable: viewModel.taxes,
                              builder: (context, value, _) {
                                return context
                                    .myDropdownButtonFormField(
                                      labelText: 'Vergi Oranı',
                                      style: context.smallTextStyle,
                                      items: value
                                          .map((e) => DropdownMenuItem(
                                                value: e.id.toString(),
                                                child: Text(e.description),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        selectedTaxRateId =
                                            int.parse(value ?? '0');
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
                                    onPressed: () =>
                                        datePicker(transactionDateController),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    .paddingVertical(context.smallPadding / 2)
                                    .paddingBottom(context.smallPadding);
                              },
                            ),
                            ValueListenableBuilder(
                              valueListenable: isPurchases,
                              builder: (BuildContext context, dynamic value,
                                  Widget? child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    viewModel.createProductMovement(
                      selectedWarehouseId!,
                      selectedWarehouseName!,
                      selectedSupplierId!,
                      selectedProductId!,
                      int.parse(priceController.text.trim()),
                      double.parse(quantityController.text.trim()),
                      selectedTaxRateId!,
                      DateTime.parse(transactionDateController.text.trim()),
                      documentNoController.text.trim(),
                      descriptionController.text.trim(),
                      selectedProjectCodeId!,
                      selectedReferenceCodeId!,
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
  }
}
