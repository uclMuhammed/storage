part of '../porject_view.dart';

class ProjectUpdate {
  final BuildContext context;
  final ProjectViewModel viewModel;
  final ProjectCode project;

  ProjectUpdate({
    required this.context,
    required this.viewModel,
    required this.project,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController =
        TextEditingController(text: project.description);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Proje Güncelle'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: context.myTextFormField(
                controller: descriptionController,
                labelText: 'Proje Açıklaması',
              ),
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
                  viewModel.updateProject(
                      project.id!, descriptionController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Güncelle'),
            ),
          ],
        );
      },
    );
  }
}
