import 'package:flutter/material.dart';
import 'package:storage/pages/home/home_widgets/more_vert/more_wert.dart';

AppBar myAppBar(
  bool changeAppbar,
  BuildContext context,
  Function() onPressed,
) {
  return AppBar(
    title: const Text(
      'WareHouse',
    ),
    actions: [
      IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.search),
      ),
      moreWert(context),
    ],
  );
}
