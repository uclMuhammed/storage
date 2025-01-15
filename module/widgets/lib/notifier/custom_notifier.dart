import 'package:flutter/material.dart';

class GenericNotifier<T> extends ValueNotifier<T> {
  GenericNotifier(super.value);

  void update(T Function(T value) updateFn) {
    value = updateFn(value);
    notifyListeners();
  }

  void change(T value) {
    this.value = value;
    notifyListeners();
  }
}
