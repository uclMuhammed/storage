import 'package:backend/backend.dart';
import 'package:backend/const/keys.dart';
import 'package:core/base/warehouses/warehouses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            onPressed: authorGetById,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Future<void> authorGetById() async {
    try {
      await _author.init();
      //
      final response = await _author.getById(1);
      //
      print(response);
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> readToken() async {
    try {
      await _author.init();
      //
      final token = await _author.storage?.read(BearerTokenKey);
      //
      if (token != null) {
        if (kDebugMode) print('Token: $token');
      } else {
        if (kDebugMode) print('Token Not Found');
      }
      //
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }
}
