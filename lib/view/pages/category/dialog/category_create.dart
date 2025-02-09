part of '../category_view.dart';

class CategoryCreate {
  final BuildContext context;
  final CategoryViewModel viewModel;

  CategoryCreate({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Kategori'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.myTextFormField(
                    labelText: 'Kategori Adı',
                    controller: nameController,
                    validator: (value) =>
                        value?.isEmpty == true ? 'Kategori adı gerekli' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('İptal')),
            TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await viewModel.createCategory(nameController.text);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: const Text('Kaydet')),
          ],
        );
      },
    );
  }
}

class CategorySubCreate {
  final BuildContext context;
  final CategoryViewModel viewModel;

  CategorySubCreate({
    required this.context,
    required this.viewModel,
  });

  Future<bool?> show(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return ValueListenableBuilder<Categories?>(
          valueListenable: viewModel.selectedCategory,
          builder: (context, category, child) {
            if (category == null) {
              return const AlertDialog(
                title: Text('Hata'),
                content: Text('Lütfen önce bir kategori seçin'),
              );
            }
            return AlertDialog(
              title: const Text('Yeni Alt Kategori'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      context.myTextFormField(
                        labelText: 'Alt Kategori Adı',
                        controller: nameController,
                        validator: (value) => value?.isEmpty == true
                            ? 'Alt Kategori adı gerekli'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('İptal')),
                TextButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await viewModel.createSubCategory(
                            nameController.text, category.id!);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Kaydet')),
              ],
            );
          },
        );
      },
    );
  }
}
