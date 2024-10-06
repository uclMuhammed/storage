import 'package:core/product/product.dart';
import 'package:flutter/material.dart';
import 'package:storage/pages/home/product_detail/product_detail.dart';

class ProductList extends StatelessWidget {
  final Function stokGuncelleDialog;
  final Function urunEkleDialog;
  final Function urunSilDialog;
  final List<Urun> urunler;
  const ProductList(
      {super.key,
      required this.urunler,
      required this.stokGuncelleDialog,
      required this.urunEkleDialog,
      required this.urunSilDialog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Ürün Listeleme
          Expanded(
            child: ListView.builder(
              itemCount: urunler.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            urun: urunler[index],
                          ),
                        ),
                      );
                    } catch (e) {
                      print("Hata: $e");
                    }
                  },
                  child: ListTile(
                    title: Text(urunler[index].isim),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Barkod: ${urunler[index].barkod}'),
                        Text('Stok: ${urunler[index].miktar}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            stokGuncelleDialog(index); // Güncelleme dialog'u aç
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            urunSilDialog(index); // Silme onay dialog'u aç
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
    );
  }
}
