part of '../tax_rate_view.dart';

class TaxRateUpdate {
  final TaxRateViewModel viewModel;
  final TaxRate taxRate;
  final BuildContext context;
  TaxRateUpdate({
    required this.context,
    required this.viewModel,
    required this.taxRate,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController =
        TextEditingController(text: taxRate.description);
    final taxRateController =
        TextEditingController(text: taxRate.tax.toString());
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vergi Oranı Düzenle'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context
                    .myTextFormField(
                      labelText: 'Açıklama',
                      controller: descriptionController,
                    )
                    .paddingBottom(context.smallPadding),
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
                  viewModel.updateTaxRate(
                    taxRate.id ?? 0,
                    descriptionController.text,
                    double.parse(taxRateController.text),
                  );
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
