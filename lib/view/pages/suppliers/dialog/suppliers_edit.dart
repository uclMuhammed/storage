part of '../suppliers_view.dart';

class SuppliersEdit {
  final Suppliers supplier;
  final BuildContext context;
  final SuppliersViewModel viewModel;
  SuppliersEdit({
    required this.supplier,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: supplier.name);
    final addressController = TextEditingController(text: supplier.address);
    final phoneController = TextEditingController(text: supplier.phone);
    final emailController = TextEditingController(text: supplier.email);
    final identityController =
        TextEditingController(text: supplier.identityNo.toString());
    int? selectedRegionId = supplier.regionId;

    return showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tedarikçi Düzenle'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context
                      .myTextFormField(
                        labelText: 'Tedarikçi Adı',
                        controller: nameController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Ad gerekli' : null,
                      )
                      .paddingBottom(context.smallPadding),
                  context
                      .myTextFormField(
                        labelText: 'Telefon',
                        controller: phoneController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Telefon gerekli' : null,
                      )
                      .paddingBottom(context.smallPadding),
                  context
                      .myTextFormField(
                        labelText: 'Email',
                        controller: emailController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Email gerekli' : null,
                      )
                      .paddingBottom(context.smallPadding),
                  context
                      .myTextFormField(
                        labelText: 'Adres',
                        controller: addressController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Adres gerekli' : null,
                      )
                      .paddingBottom(context.smallPadding),
                  context
                      .myTextFormField(
                        labelText: 'Vergi Kimlik Numarası',
                        controller: identityController,
                        validator: (value) => value?.isEmpty == true
                            ? 'Vergi kimlik numarası gerekli'
                            : null,
                      )
                      .paddingBottom(context.smallPadding),
                  ValueListenableBuilder(
                    valueListenable: viewModel.regions,
                    builder: (context, regions, _) {
                      regions.firstWhere(
                        (region) => region.id == selectedRegionId,
                        orElse: () => Regions.empty(),
                      );
                      return DropdownButtonFormField<int>(
                        value: selectedRegionId,
                        items: regions.map((region) {
                          return DropdownMenuItem(
                            value: region.id,
                            child: Text(region.description),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedRegionId = value;
                        },
                        validator: (value) =>
                            value == null ? 'Bölge seçiniz' : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  await viewModel.updateSupplier(
                    supplier.id!,
                    nameController.text,
                    selectedRegionId ?? 0,
                    addressController.text,
                    identityController.text,
                    phoneController.text,
                    emailController.text,
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
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
