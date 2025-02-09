part of '../warehouses_view.dart';

class WarehousesDelete {
  final Warehouses warehouse;
  final BuildContext context;
  final WarehousesViewModel viewModel;

  WarehousesDelete({
    required this.warehouse,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Depo Sil'),
          content: Text(
              '${warehouse.description} deposunu silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await viewModel.deleteWarehouse(warehouse.id!);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, false);
                }
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
