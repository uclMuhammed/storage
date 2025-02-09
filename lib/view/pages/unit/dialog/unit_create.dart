part of '../unit_view.dart';

class UnitCreate {
  final BuildContext context;
  final UnitViewModel viewModel;

  UnitCreate({
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final quantityController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Birim'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context
                    .myTextFormField(
                      labelText: 'Birim Adı',
                      controller: nameController,
                      validator: (value) =>
                          value?.isEmpty == true ? 'Birim adı gerekli' : null,
                    )
                    .paddingBottom(context.smallPadding),
                context.myTextFormField(
                  labelText: 'Miktar',
                  controller: quantityController,
                  validator: (value) {
                    if (value?.isEmpty == true) return 'Miktar gerekli';
                    final quantity = double.tryParse(value!);
                    if (quantity == null) return 'Geçerli bir sayı girin';
                    if (quantity <= 0) return 'Miktar 0\'dan büyük olmalı';
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await viewModel.createUnit(
                    nameController.text,
                    double.parse(quantityController.text),
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
