part of '../suppliers_view.dart';

class SuppliersCreate {
  final BuildContext context;
  final SuppliersViewModel viewModel;

  SuppliersCreate({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final identityController = TextEditingController();
    int? selectedRegionId;

    final authClient = ServiceAuthClient();
    final token = await authClient.getToken();

    final regionService = ServiceApiClient<Regions>(
      baseUrl: StockTrackerApiUrl,
      endPoint: '/regions',
      fromJson: (json) => Regions.fromJson(json),
      header: HeaderWithToken(token ?? ''),
    )..init();

    return showDialog<bool>(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Tedarikçi Ekle'),
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
                        validator: (value) => value?.isEmpty == true
                            ? 'Tedarikçi adı gerekli'
                            : null,
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
                  FutureBuilder(
                    future: regionService.getAll(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final regions = snapshot.data ?? [];
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
                  await viewModel.createSupplier(
                    nameController.text,
                    addressController.text,
                    identityController.text,
                    phoneController.text,
                    emailController.text,
                    selectedRegionId ?? 0,
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
