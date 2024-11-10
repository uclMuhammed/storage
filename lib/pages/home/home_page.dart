import 'package:core/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';
import 'package:storage/pages/home/home_body/product_list.dart';
import 'package:storage/pages/home/home_widgets/appbar/appbar.dart';
import 'package:storage/pages/home/home_widgets/appbar/searchbar.dart';
import 'package:storage/pages/home/home_widgets/drawer/drawer.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text_form_field/text_form_field.dart';
part 'home_page_mixin.dart';

class HomePage extends StatefulWidget {
  final AuthManager authManager;
  const HomePage({super.key, required this.authManager});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => WillPopScope(
        onWillPop: () async {
          await widget.authManager.logout();
          return true;
        },
        child: Scaffold(
          appBar: changeAppBar
              ? searchbar(
                  _searchController,
                  () {
                    changeAppBar = !changeAppBar;
                    _searchController.clear();
                    setState(() {});
                  },
                  (value) {},
                )
              : myAppBar(changeAppBar, widget.authManager, context, () {
                  changeAppBar = !changeAppBar;
                  setState(() {});
                }),
          drawer: changeAppBar
              ? null
              : MyDrawer(
                  authManager: widget.authManager,
                ),
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
              urunler: filteredUrunler,
              stokGuncelleDialog: _stokGuncelleDialog,
              urunEkleDialog: _urunEkleDialog,
              urunSilDialog: _urunSilDialog),
        ),
      ),
    );
  }
}
