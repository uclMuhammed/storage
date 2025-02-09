part of '../porject_view.dart';

class ProjectDelete {
  final BuildContext context;
  final ProjectViewModel viewModel;
  final ProjectCode project;

  ProjectDelete({
    required this.context,
    required this.viewModel,
    required this.project,
  });

  Future<void> show() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Proje Sil'),
          content: Text(
            '${project.description} projesini silmek istediğinize emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteProject(project.id ?? 0);
                Navigator.pop(context);
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
