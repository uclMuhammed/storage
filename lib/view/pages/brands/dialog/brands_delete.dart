part of '../brands_view.dart';

class BrandsDelete extends StatelessWidget {
  final BuildContext context;
  final BrandsViewModel viewModel;
  final Brands brand;

  const BrandsDelete({
    required this.context,
    required this.viewModel,
    required this.brand,
    super.key,
  });

  Future<void> show() async {
    await showDialog(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Marka Sil'),
      content: Text(
        '${brand.description} markasını silmek istediğinizden emin misiniz?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () async {
            await viewModel.deleteBrand(brand.id!);
            if (context.mounted) Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Sil'),
        ),
      ],
    );
  }
}
