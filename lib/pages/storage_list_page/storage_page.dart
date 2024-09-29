import 'package:core/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
part 'storage_mixin.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  StorageScreenState createState() => StorageScreenState();
}

class StorageScreenState extends State<StorageScreen> with StorageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('DEPOM'),
        actions: const [Icon(Icons.filter_list)],
        centerTitle: true,
      ),
      drawer: const Drawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: _urunEkleDialog,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: const Icon(Icons.add),
            ),
            const Spacer(),
            FloatingActionButton(
              onPressed: scanBarcodeNormal,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              child: const Icon(Icons.barcode_reader),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ürün Listeleme
            Expanded(
              child: ListView.builder(
                itemCount: _urunler.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                      title: Text(_urunler[index].isim),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Barkod: ${_urunler[index].barkod}'),
                          Text('Stok: ${_urunler[index].miktar}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _stokGuncelleDialog(
                                  index); // Güncelleme dialog'u aç
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _urunSilDialog(index); // Silme onay dialog'u aç
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
