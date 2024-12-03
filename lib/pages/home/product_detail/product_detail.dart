import 'package:flutter/material.dart';
import 'package:widgets/padding/padding.dart';
import 'package:widgets/text/normaltext.dart';
import 'package:widgets/text/titletext.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          title: const Titletext(text: "Ürün Detayları"),
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
                  const Normaltext(text: "Urun Partino: "),
                  const Normaltext(text: "Urun Barkodu:"),
                  const Normaltext(text: "Urun Miktarı: "),
                  const Normaltext(text: "UT: "),
                  const Normaltext(text: "SKT: "),
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
                child: const Column(
                  children: [],
                ),
              ).centerX(),
            ),
          ],
        ),
      );
    });
  }
}
