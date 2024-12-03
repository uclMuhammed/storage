import 'package:backend/backend.dart';
import 'package:backend/const/keys.dart';
import 'package:backend/service/authorities_service.dart';
import 'package:flutter/foundation.dart';
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
          body: ListView.builder(itemBuilder: (context, index) {
            return const ListTile(
              title: Text("DEPO ADI: "),
              subtitle: Text("DEPO YERİ: "),
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
      if (kDebugMode) {
        print(response);
      }
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
