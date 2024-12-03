import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/material.dart';
import 'package:backend/models/index.dart';

import '../../service_management/service_manager.dart';
part 'brands_mixin.dart';

class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> with BrandsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markalar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshBrands,
          ),
        ],
      ),
      body: FutureBuilder<List<Brands>>(
        future: _brandsFuture,
        builder: (context, snapshot) {
          if (_brandsService == null || _brandsFuture == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Marka bulunamadı'));
          }

          final brands = snapshot.data!;
          return ListView.builder(
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return ListTile(
                title: Text(brand.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _brandsService != null
                          ? showBrandDialog(context, _brandsService!, brand: brand)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        if (_brandsService != null) {
                          await deleteBrand(context, _brandsService!, brand);
                          _refreshBrands();
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
        onPressed: () => _brandsService != null ? showBrandDialog(context, _brandsService!) : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
