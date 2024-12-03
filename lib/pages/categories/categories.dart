import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/material.dart';
import 'package:backend/models/index.dart';

import '../../service_management/service_manager.dart';
part 'categories_mixin.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> with CategoriesMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCategories,
          ),
        ],
      ),
      body: FutureBuilder<List<Categories>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (_categoriesService == null ||
              _categoriesFuture == null ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Veri yükleniyor...'),
            );
          }

          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _categoriesService != null
                          ? showCategoryDialog(context, _categoriesService!, category: category)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        if (_categoriesService != null) {
                          await deleteCategory(context, _categoriesService!, category);
                          _refreshCategories();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _categoriesService != null ? showCategoryDialog(context, _categoriesService!) : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
