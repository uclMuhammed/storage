import 'package:flutter/material.dart';

AppBar searchbar(
    TextEditingController controller, Function() onPressed, Function(String) onChanged) {
  return AppBar(
    title: TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "Search...",
        suffixIcon: Icon(Icons.search),
      ),
      style: const TextStyle(fontSize: 20),
      onChanged: onChanged,
    ),
    centerTitle: true,
    leading: IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back_ios_new)),
  );
}
