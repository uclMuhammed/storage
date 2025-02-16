import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  BuildContext get context {
    if (_context == null) {
      throw Exception('Context is not set. Call setContext() first.');
    }
    return _context!;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void get onLoading {
    _isLoading = true;
    notifyListeners();
  }

  void get offLoading {
    _isLoading = false;
    notifyListeners();
  }

  void init();
}
