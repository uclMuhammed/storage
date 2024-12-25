import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/shared_preferences.dart';

class SharedPreferencesService extends BaseSharedPreferences {
  static SharedPreferencesService? _instance;
  final SharedPreferences _sharedPreferences;
  //
  SharedPreferencesService._({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;
  //
  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesService._(sharedPreferences: sharedPreferences);
    }
    return _instance!;
  }

  @override
  Future<T?> read<T>(String key) async {
    try {
      final value = _sharedPreferences.get(key);
      //
      if (value != null && value is T) {
        return value as T;
      }
      //
      return null;
    } catch (e) {
      if (kDebugMode) print('Error reading from SharedPreferences: $e');
      //
      return null;
    }
  }

  @override
  Future<bool> write<T>(String key, T value) async {
    try {
      //
      if (value is String) {
        await _sharedPreferences.setString(key, value.toString());
      } else if (value is int) {
        await _sharedPreferences.setInt(key, value);
      } else if (value is double) {
        await _sharedPreferences.setDouble(key, value);
      } else if (value is bool) {
        await _sharedPreferences.setBool(key, value);
      } else if (value is List<String>) {
        await _sharedPreferences.setStringList(key, value);
      } else {
        throw UnimplementedError('Type ${T.toString()} not supported');
      }
      //
      return true;
      //
    } catch (e) {
      if (kDebugMode) print('Error writing to SharedPreferences: $e');
      //
      return false;
    }
  }

  @override
  Future<bool> update<T>(String key, T value) async {
    try {
      //
      return await write(key, value);
      //
    } catch (e) {
      if (kDebugMode) print('Error updating SharedPreferences: $e');
      //
      return false;
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      //
      return await _sharedPreferences.remove(key);
      //
    } catch (e) {
      if (kDebugMode) print('Error deleting from SharedPreferences: $e');
      //
      return false;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      //
      return await _sharedPreferences.clear();
      //
    } catch (e) {
      if (kDebugMode) print('Error clearing SharedPreferences: $e');
      //
      return false;
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      //
      return _sharedPreferences.containsKey(key);
      //
    } catch (e) {
      if (kDebugMode) print('Error checking SharedPreferences key: $e');
      //
      return false;
    }
  }
}
