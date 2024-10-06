import 'package:core/product/product.dart';
import 'package:flutter/material.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text/normaltext.dart';
import 'package:widgets/text/titletext.dart';

class ProductDetail extends StatelessWidget {
  final Urun urun;
  const ProductDetail({super.key, required this.urun});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          title: Titletext(text: urun.isim),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.maxHeight * 0.01,
                  ),
                  Normaltext(text: "Urun Partino: ${urun.partino}"),
                  Normaltext(text: "Urun Barkodu: ${urun.barkod}"),
                  Normaltext(text: "Urun Miktarı: ${urun.miktar}"),
                  Normaltext(
                      text:
                          "UT: ${urun.uretimtarihi.toString().replaceRange(16, null, "")}"),
                  Normaltext(
                      text:
                          "SKT: ${urun.sontuketimtarihi.toString().replaceRange(16, null, "")}"),
                ],
              ).paddingAll(8),
            ).centerX(),
            SizedBox(
              height: size.maxHeight * 0.05,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Text(urun.partino),
                    Text(urun.barkod),
                    Text(urun.isim),
                    Text(urun.uretimtarihi
                        .toString()
                        .replaceRange(16, null, "")),
                    Text(urun.sontuketimtarihi
                        .toString()
                        .replaceRange(16, null, "")),
                    Text(urun.miktar.toString()),
                  ],
                ),
              ).centerX(),
            ),
          ],
        ),
      );
    });
  }
}
