part of '../reference_view.dart';

class ReferenceUpdate {
  final ReferenceViewModel viewModel;
  final ReferenceCode reference;
  final BuildContext context;
  ReferenceUpdate({
    required this.context,
    required this.viewModel,
    required this.reference,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController =
        TextEditingController(text: reference.description);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Reference'),
        content: Form(
          key: formKey,
          child: context.myTextFormField(
            controller: descriptionController,
            labelText: 'Referans Açıklaması',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                viewModel.updateReference(
                    reference.id ?? 0, descriptionController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Güncelle'),
          ),
        ],
      ),
    );
  }
}
