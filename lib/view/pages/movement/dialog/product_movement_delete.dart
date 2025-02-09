part of '../product_movement_view.dart';

class ProductMovementDelete {
  final BuildContext context;
  final ProductMovementViewModel viewModel;

  ProductMovementDelete({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ürün Hareketi Sil'),
          content: Text(
            '${viewModel.selectedProductMovement.value?.description} hareketini silmek istediğinize emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                await viewModel.deleteProductMovement(
                  viewModel.selectedProductMovement.value!.id!,
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context, true);
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
