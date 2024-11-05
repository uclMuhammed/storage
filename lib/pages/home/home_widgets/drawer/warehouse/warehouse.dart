import 'package:core/base/warehouses/warehouses.dart';
import 'package:flutter/material.dart';
import 'package:widgets/text_form_field/text_form_field.dart';
part 'warehouse_mixin.dart';

class WareHouse extends StatefulWidget {
  const WareHouse({super.key});

  @override
  State<WareHouse> createState() => _WareHouseState();
}

class _WareHouseState extends State<WareHouse> with WareHouseMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("D E P O L A R I M"),
            centerTitle: true,
          ),
          body: ListView.builder(
              itemCount: depolar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("DEPO ADI: ${depolar[index].description}"),
                  subtitle: Text("DEPO YERİ: ${depolar[index].address}"),
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: addButton,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
