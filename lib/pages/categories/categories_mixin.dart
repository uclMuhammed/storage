part of 'categories.dart';

mixin CategoriesMixin<T extends StatefulWidget> on State<T> {
  GenericApiService<Categories>? _categoriesService;
  Future<List<Categories>>? _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    _categoriesService =
        await ServiceManager().getService<GenericApiService<Categories>>(runtimeType);
    _refreshCategories();
  }

  void _refreshCategories() {
    if (_categoriesService != null) {
      setState(() {
        _categoriesFuture = _categoriesService!.getAll();
      });
    }
  }

  Future<void> deleteCategory(BuildContext context, GenericApiService<Categories> categoriesService,
      Categories category) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${category.description} silinsin mi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              await categoriesService.delete(category.id);
              if (mounted) {
                Navigator.pop(context);
                _refreshCategories();
              }
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  Future<void> showCategoryDialog(
      BuildContext context, GenericApiService<Categories> categoriesService,
      {Categories? category}) async {
    final TextEditingController descriptionController =
        TextEditingController(text: category?.description);
    final TextEditingController companyIdController =
        TextEditingController(text: category?.companyId.toString());

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(category == null ? 'Yeni Kategori Ekle' : 'Kategoriyi Düzenle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Kategori Adı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: companyIdController,
              decoration: const InputDecoration(
                labelText: 'Şirket Kodu',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              if (descriptionController.text.isNotEmpty && companyIdController.text.isNotEmpty) {
                if (category == null) {
                  await _createCategory(context, categoriesService,
                      description: descriptionController.text,
                      companyId: int.parse(companyIdController.text));
                } else {
                  await _updateCategory(
                    context,
                    categoriesService,
                    Categories(
                      category: category.category,
                      description: descriptionController.text,
                      companyId: int.parse(companyIdController.text),
                      id: category.id,
                      isActive: category.isActive,
                      isDelete: category.isDelete,
                      createdAt: category.createdAt,
                      createdBy: category.createdBy,
                      updatedAt: DateTime.now(),
                      updatedBy: '',
                      deletedBy: category.deletedBy,
                      deletedAt: category.deletedAt,
                    ),
                  );
                }
                if (mounted) {
                  Navigator.pop(context);
                  _refreshCategories();
                }
              }
            },
            child: Text(category == null ? 'Ekle' : 'Güncelle'),
          ),
        ],
      ),
    );
  }

  Future<void> _createCategory(
      BuildContext context, GenericApiService<Categories> categoriesService,
      {required String description, required int companyId}) async {
    try {
      final newCategory = Categories(
        category: 0,
        description: description,
        companyId: companyId,
        id: 0,
        isActive: true,
        isDelete: false,
        createdAt: DateTime.now(),
        createdBy: '',
        updatedAt: null,
        updatedBy: null,
        deletedBy: null,
        deletedAt: null,
      );

      await categoriesService.create(newCategory);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kategori başarıyla eklendi')),
        );
        _refreshCategories();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }

  Future<void> _updateCategory(BuildContext context,
      GenericApiService<Categories> categoriesService, Categories category) async {
    try {
      await categoriesService.update(category.id, category);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kategori başarıyla güncellendi')),
        );
        _refreshCategories();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }
}
