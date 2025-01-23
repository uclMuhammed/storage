import 'package:flutter/material.dart';

class DrawerModel {
  final String title;
  final IconData icon;
  Widget? page;

  DrawerModel({
    required this.title,
    required this.icon,
    this.page,
  });
}
