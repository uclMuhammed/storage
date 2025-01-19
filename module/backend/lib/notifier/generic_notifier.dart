import 'package:flutter/foundation.dart';

/// A generic notifier class that can be used to notify listeners of changes to a value
class GenericNotifier<T> extends ChangeNotifier {
  GenericNotifier(this._value);

  T _value;

  /// Get the current value
  T get value => _value;

  /// Update the value and notify listeners
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  /// Update the value without notifying listeners
  void silentUpdate(T newValue) {
    _value = newValue;
  }

  /// Update the value and force notify listeners even if the value hasn't changed
  void forceUpdate(T newValue) {
    _value = newValue;
    notifyListeners();
  }
}
