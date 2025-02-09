part of '../unit_view.dart';

class UnitUpdate {
  final ProductUnits unit;
  final BuildContext context;
  final UnitViewModel viewModel;

  UnitUpdate({
    required this.unit,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final descriptionController = TextEditingController(text: unit.description);
    final quantityController =
        TextEditingController(text: unit.quantity.toString());
    bool isActive = unit.isActive ?? true;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Birim Güncelle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              context
                  .myTextFormField(
                    labelText: 'Birim Adı',
                    controller: descriptionController,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Birim adı gerekli' : null,
                  )
                  .paddingBottom(context.smallPadding),
              context.myTextFormField(
                labelText: 'Miktar',
                controller: quantityController,
                validator: (value) =>
                    value?.isEmpty == true ? 'Miktar gerekli' : null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                final quantity = double.tryParse(quantityController.text);
                if (quantity == null || quantity <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen geçerli bir miktar giriniz'),
                    ),
                  );
                  return;
                }

                await viewModel.updateUnit(
                  descriptionController.text,
                  quantity,
                  isActive,
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Güncelle'),
            ),
          ],
        );
      },
    );
  }
}
