part of '../product_view.dart';

class ProductDelete {
  final Products product;
  final BuildContext context;
  final ProductViewModel viewModel;

  ProductDelete({
    required this.product,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ürün Sil'),
          content: Text(
              '${product.description} ürününü silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await viewModel.deleteProduct(product.id!);
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
