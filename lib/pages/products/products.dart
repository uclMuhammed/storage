import 'package:backend/backend.dart';
import 'package:backend/service/generic_api_service.dart';
import 'package:backend/storage/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/service_management/multi_service_builder.dart';
import 'package:widgets/text_form_field/text_form_field.dart';

import '../../service_management/service_manager.dart';
part 'products_mixin.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> with ProductsMixin {
  @override
  Widget build(BuildContext context) {
    return MultiServiceBuilder(
      serviceTypes: const [
        GenericApiService<Brands>,
        GenericApiService<Products>,
        GenericApiService<Categories>,
        GenericApiService<ProductUnits>,
      ],
      builder: (context, services) {
        final brandsResponse = services[GenericApiService<Brands>] as ServiceResponse<Brands>;
        final productsResponse = services[GenericApiService<Products>] as ServiceResponse<Products>;
        final categoriesResponse =
            services[GenericApiService<Categories>] as ServiceResponse<Categories>;
        final unitsResponse =
            services[GenericApiService<ProductUnits>] as ServiceResponse<ProductUnits>;

        final brands = brandsResponse.data;
        final products = productsResponse.data;
        final categories = categoriesResponse.data;
        final units = unitsResponse.data;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Ürünler'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => setState(() {}),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Hata durumlarını göster
                  if (categories.isEmpty || products.isEmpty)
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.orange),
                              SizedBox(width: 8),
                              Text(
                                'Sistem Bildirimi',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (categories.isEmpty)
                            const Text('• Kategoriler yüklenemiyor (AuthorID hatası)'),
                          if (products.isEmpty)
                            const Text('• Ürünler yüklenemiyor (AuthorID hatası)'),
                          const SizedBox(height: 8),
                          const Text(
                            'Bu sorun sistem yöneticisi tarafından çözülene kadar bazı özellikler kısıtlı olabilir.',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                  // Marka listesi
                  if (brands.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.business, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Markalar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        final brand = brands[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            leading: const Icon(Icons.label_outline),
                            title: Text(brand.description),
                            subtitle: Text('Marka ID: ${brand.brand}'),
                            trailing: Text('Şirket ID: ${brand.companyId}'),
                          ),
                        );
                      },
                    ),
                  ] else
                    const Center(child: Text('Henüz marka bulunmuyor')),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: brands.isEmpty
                ? null // Marka yoksa devre dışı bırak
                : () => showProductDialog(
                      context,
                      productsResponse,
                      brandsResponse,
                      unitsResponse,
                      categoriesResponse,
                      categories: categories,
                      brands: brands,
                      units: units,
                    ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
