import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../abstract/storage.dart';

class ServiceSecureStorage extends IStorage {
  late final FlutterSecureStorage? _storage;
  //
  @override
  Future<void> init() async {
    try {
      _storage = const FlutterSecureStorage();
    } catch (e) {
      throw handlerException(e, message: 'Failed to initialize storage');
    }
  }

  @override
  Future<void> dispose() async {
    try {
      _storage = null;
    } catch (e) {
      throw handlerException(e, message: 'Failed to dispose storage');
    }
  }

  @override
  Future<T?> read<T>(String key) async {
    try {
      final value = await _storage?.read(key: key);
      //
      if (value == null) {
        return null;
      }
      //
      if (T is String) {
        return value as T;
      } else if (T is int) {
        return int.tryParse(value) as T;
      } else if (T is DateTime) {
        return DateTime.tryParse(value) as T;
      } else if (T is double) {
        return double.tryParse(value) as T;
      } else if (T is bool) {
        return bool.tryParse(value) as T;
      } else {
        throw handlerException(Exception(),
            message: 'Failed to read storage, type not found');
      }
    } catch (e) {
      throw handlerException(e, message: 'Failed to read storage');
    }
  }

  @override
  Future<bool> write<T>(String key, T value) async {
    try {
      await _storage?.write(key: key, value: value.toString());
      return true;
    } catch (e) {
      throw handlerException(e, message: 'Failed to write storage');
    }
  }

  @override
  Future<bool> update<T>(String key, T value) async {
    try {
      final existKey = await _storage?.containsKey(key: key);
      if (existKey == false) {
        throw handlerException(
          Exception(),
          message: 'Failed to update storage, key not found',
        );
      }
      await _storage?.write(key: key, value: value.toString());
      return true;
    } catch (e) {
      throw handlerException(e, message: 'Failed to update storage');
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      final existKey = await _storage?.containsKey(key: key);
      if (existKey == false) {
        throw handlerException(
          Exception(),
          message: 'Failed to delete storage, key not found',
        );
      }
      await _storage?.delete(key: key);
      return true;
    } catch (e) {
      throw handlerException(e, message: 'Failed to delete storage');
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await _storage?.deleteAll();
      return true;
    } catch (e) {
      throw handlerException(e, message: 'Failed to clear storage');
    }
  }

  @override
  Future<bool> containsKey(String key) async {
    try {
      final existKey = await _storage?.containsKey(key: key);
      return existKey ?? false;
    } catch (e) {
      throw handlerException(e, message: 'Failed to check key storage');
    }
  }
}
