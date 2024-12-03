import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/material.dart';
import 'package:backend/backend.dart';

import '../service_management/service_builder.dart';
import '../service_management/service_manager.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  // List'i tutmak için state ekleyelim
  late Future<List<Brands>> _brandsFuture;

  @override
  void initState() {
    super.initState();
    _initBrandsFuture();
  }

  void _initBrandsFuture() {
    _brandsFuture = ServiceManager()
        .getService<GenericApiService<Brands>>(runtimeType)
        .then((service) => service.getAll());
  }

  Future<void> _refreshBrands() async {
    setState(() {
      _initBrandsFuture(); // Future'ı yeniden oluştur
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markalar'),
      ),
      body: ServiceBuilder<Brands>(
        builder: (context, service) {
          return FutureBuilder<List<Brands>>(
            future: _brandsFuture, // State'teki future'ı kullan
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final brands = snapshot.data!;
              return RefreshIndicator(
                onRefresh: _refreshBrands,
                child: ListView.builder(
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    final brand = brands[index];
                    return Dismissible(
                      key: Key(brand.id.toString()),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Silme Onayı'),
                            content: Text(
                                '${brand.description} markasını silmek istediğinize emin misiniz?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('İptal'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Sil'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) async {
                        try {
                          await service.delete(brand.id);
                          // Silme başarılı olduktan sonra listeyi yenile
                          if (mounted) {
                            _refreshBrands(); // Listeyi yenile
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${brand.description} silindi')),
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            // Hata durumunda listeyi eski haline getir
                            _refreshBrands();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Hata: $e')),
                            );
                          }
                        }
                      },
                      child: ListTile(
                        title: Text(brand.description),
                        subtitle: Text('Marka ID: ${brand.brand}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BrandFormScreen(brand: brand),
                              ),
                            );
                            if (result == true) {
                              _refreshBrands();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BrandFormScreen(),
            ),
          );
          if (result == true) {
            _refreshBrands();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// lib/features/brands/screens/brand_form_screen.dart
class BrandFormScreen extends StatefulWidget {
  final Brands? brand;

  const BrandFormScreen({Key? key, this.brand}) : super(key: key);

  @override
  State<BrandFormScreen> createState() => _BrandFormScreenState();
}

class _BrandFormScreenState extends State<BrandFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late int _companyId;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.brand?.description);
    _companyId = widget.brand?.companyId ?? 1; // Varsayılan şirket ID'si
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand == null ? 'Yeni Marka' : 'Markayı Düzenle'),
      ),
      body: ServiceBuilder<Brands>(
        builder: (context, service) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Marka Adı',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Marka adı gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _saveBrand(service),
                  child: Text(widget.brand == null ? 'Ekle' : 'Güncelle'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // brand_form_screen.dart içindeki _saveBrand metodunu güncelleyelim
  Future<void> _saveBrand(GenericApiService<Brands> service) async {
    if (_formKey.currentState!.validate()) {
      try {
        // API'nin beklediği formatta brand nesnesi oluşturalım
        final brand = Brands(
          brand: widget.brand?.brand ?? 0,
          companyId: _companyId,
          description: _descriptionController.text.trim(), // Boşlukları temizleyelim
          id: widget.brand?.id ?? 0,
          isActive: true,
          isDelete: false,
          createdAt: widget.brand?.createdAt ?? DateTime.now(),
          createdBy: widget.brand?.createdBy ?? '',
          updatedAt: widget.brand != null ? DateTime.now() : null,
          updatedBy: widget.brand != null ? '' : null,
          deletedAt: null,
          deletedBy: null,
        );

        // API isteğini debug edelim
        print('Sending brand data: ${brand.toJson()}');

        if (widget.brand == null) {
          await service.create(brand);
        } else {
          await service.update(brand.id, brand);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Marka başarıyla kaydedildi')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        print('Save Brand Error: $e'); // Hatayı logla
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
