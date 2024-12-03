import 'package:backend/models/index.dart';
import 'package:flutter/material.dart';
import 'package:storage/service_management/service_builder.dart';

class ProductList extends StatelessWidget {
  final Function stokGuncelleDialog;
  final Function urunEkleDialog;
  final Function urunSilDialog;
  const ProductList(
      {super.key,
      required this.stokGuncelleDialog,
      required this.urunEkleDialog,
      required this.urunSilDialog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ServiceBuilder<Products>(builder: (context, service) {
        return FutureBuilder<List<Products>>(
          future: service.getAll(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final products = snapshot.data!;
            print(products);
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.id.toString()),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => urunEkleDialog(product),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => urunSilDialog(index),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
