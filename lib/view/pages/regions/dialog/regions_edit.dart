part of '../regions_view.dart';

class RegionsEdit {
  final Regions region;
  final BuildContext context;
  final RegionsViewModel viewModel;

  RegionsEdit({
    required this.region,
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: region.description);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Bölge Düzenle'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context
                      .myTextFormField(
                        labelText: 'Bölge Adı',
                        controller: nameController,
                        validator: (value) =>
                            value?.isEmpty == true ? 'Bölge adı gerekli' : null,
                      )
                      .paddingVertical(context.smallPadding),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                if (formKey.currentState?.validate() == true) {
                  await viewModel.updateRegion(region.id!, nameController.text);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }
}
