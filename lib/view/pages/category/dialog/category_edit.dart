part of '../category_view.dart';

class CategoryEdit {
  final BuildContext context;
  final CategoryViewModel viewModel;
  final Categories category;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  CategoryEdit({
    required this.context,
    required this.viewModel,
    required this.category,
  }) {
    _nameController.text = category.description;
  }

  Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategori Düzenle'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Kategori Adı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kategori adı girin';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await viewModel.updateCategory(_nameController.text);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}

class CategorySubEdit {
  final BuildContext context;
  final CategoryViewModel viewModel;
  final CategoriesSub subCategory;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  CategorySubEdit({
    required this.context,
    required this.viewModel,
    required this.subCategory,
  }) {
    _nameController.text = subCategory.description;
  }

  Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alt Kategori Düzenle'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Alt Kategori Adı',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen alt kategori adı girin';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await viewModel.updateSubCategory(_nameController.text);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}
