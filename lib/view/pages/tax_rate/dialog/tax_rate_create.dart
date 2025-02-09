part of '../tax_rate_view.dart';

class TaxRateCreate {
  final BuildContext context;
  final TaxRateViewModel viewModel;
  TaxRateCreate({
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController = TextEditingController();
    final taxRateController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vergi Oranı Oluştur'),
          content: Form(
            key: formKey,
            child: Column(
              children: [
                context.myTextFormField(
                  labelText: 'Açıklama',
                  controller: descriptionController,
                ),
                context.myTextFormField(
                  labelText: 'Vergi Oranı',
                  controller: taxRateController,
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
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  viewModel.createTaxRate(
                    descriptionController.text,
                    double.parse(taxRateController.text),
                  );
                }
              },
              child: const Text('Oluştur'),
            ),
          ],
        );
      },
    );
  }
}
