part of '../porject_view.dart';

class ProjectCreate {
  final BuildContext context;
  final ProjectViewModel viewModel;

  ProjectCreate({
    required this.context,
    required this.viewModel,
  });

  Future<void> show() async {
    final formKey = GlobalKey<FormState>();
    final descriptionController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _showDatePicker(TextEditingController controller) async {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2077),
      );
      if (date != null) {
        controller.text = date.toString().replaceRange(10, null, '');
      }
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Proje Oluştur'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  context
                      .myTextFormField(
                        controller: descriptionController,
                        labelText: 'Proje Açıklaması',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Proje Açıklaması boş bırakılamaz';
                          }
                          return null;
                        },
                      )
                      .paddingBottom(context.smallPadding),
                  context
                      .myTextFormField(
                        controller: startDateController,
                        labelText: 'Başlangıç Tarihi',
                        hintText: 'yyyy-mm-dd',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Başlangıç tarihi boş bırakılamaz';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () => _showDatePicker(startDateController),
                          icon: const Icon(Icons.calendar_month),
                        ),
                      )
                      .paddingBottom(context.smallPadding),
                  context.myTextFormField(
                    controller: endDateController,
                    labelText: 'Bitiş Tarihi',
                    hintText: 'yyyy-mm-dd',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitiş tarihi boş bırakılamaz';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () => _showDatePicker(endDateController),
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
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
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  viewModel.createProject(
                    descriptionController.text,
                    DateTime.parse(startDateController.text),
                    DateTime.parse(endDateController.text),
                  );
                  Navigator.pop(context);
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
