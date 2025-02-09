part of '../tax_rate_view.dart';

class TaxRateDelete {
  final BuildContext context;
  final TaxRateViewModel viewModel;
  final TaxRate taxRate;
  TaxRateDelete({
    required this.context,
    required this.viewModel,
    required this.taxRate,
  });

  Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vergi Oranı Sil'),
          content: Text(
              '${taxRate.description} oranını silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteTaxRate(taxRate.id ?? 0);
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
