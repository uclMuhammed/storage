import 'package:core/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:storage/pages/home/home_body/product_list.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text_form_field/text_form_field.dart';
part 'home_page_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'WareHouse',
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        drawer: const Drawer(),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              heroTag: "urunEkle",
              onPressed: _urunEkleDialog,
              child: const Icon(Icons.add),
            ),
            const Spacer(),
            FloatingActionButton(
              heroTag: "barcodeReader",
              onPressed: scanBarcodeNormal,
              child: const Icon(Icons.barcode_reader),
            ),
          ],
        ).paddingAll(16),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ProductList(
            urunler: _urunler,
            stokGuncelleDialog: _stokGuncelleDialog,
            urunEkleDialog: _urunEkleDialog,
            urunSilDialog: _urunSilDialog),
      ),
    );
  }
}
