import 'package:backend/models/index.dart';
import 'package:flutter/material.dart';

import '../service_management/service_builder.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kategoriler')),
      body: ServiceBuilder<Categories>(
        builder: (context, service) {
          return FutureBuilder<List<Categories>>(
            future: service.getAll(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final categories = snapshot.data!;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    title: Text(category.description),
                    // UI elemanları...
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
