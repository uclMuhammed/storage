part of '../brands_view.dart';

class BrandsCreate {
  final BuildContext context;
  final BrandsViewModel viewModel;

  BrandsCreate({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Marka'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.myTextFormField(
                    labelText: 'Marka Adı',
                    controller: nameController,
                    prefixIcon: Icons.branding_watermark,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen marka adı giriniz';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await viewModel.createBrand(nameController.text);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
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
