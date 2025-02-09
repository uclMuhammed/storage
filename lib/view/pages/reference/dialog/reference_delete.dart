part of '../reference_view.dart';

class ReferenceDelete {
  final ReferenceViewModel viewModel;
  final BuildContext context;
  final ReferenceCode reference;
  ReferenceDelete(
      {required this.context,
      required this.viewModel,
      required this.reference});

  Future<void> show() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Referans Sil'),
        content: Text(
          '${reference.description} silmek istediğinize emin misiniz?',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal')),
          TextButton(
            onPressed: () {
              viewModel.deleteReference(reference.id ?? 0);
              Navigator.pop(context);
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
