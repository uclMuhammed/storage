part of '../unit_view.dart';

class UnitDelete {
  final ProductUnits unit;
  final BuildContext context;
  final UnitViewModel viewModel;

  UnitDelete({
    required this.unit,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Birim Sil'),
          content: Text(
              '${unit.description} birimini silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                await viewModel.deleteUnit(unit.id!);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
