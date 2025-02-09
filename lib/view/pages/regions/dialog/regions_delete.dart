part of '../regions_view.dart';

class RegionsDelete {
  final Regions region;
  final BuildContext context;
  final RegionsViewModel viewModel;

  RegionsDelete({
    required this.context,
    required this.viewModel,
    required this.region,
  });

  Future<bool?> show() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bölge Sil'),
          content: Text(
              '${region.description} bölgesini silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await viewModel.deleteRegion(region.id!);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, false);
                }
              },
              child: const Text(
                'Sil',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
