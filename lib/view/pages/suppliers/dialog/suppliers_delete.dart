part of '../suppliers_view.dart';

class SuppliersDelete {
  final Suppliers supplier;
  final BuildContext context;
  final SuppliersViewModel viewModel;
  SuppliersDelete({
    required this.supplier,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tedarikçi Sil'),
          content: Text(
              '${supplier.name} tedarikçisini silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await viewModel.deleteSupplier(supplier.id!);
                  viewModel.refreshTrigger.value =
                      !viewModel.refreshTrigger.value;
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
