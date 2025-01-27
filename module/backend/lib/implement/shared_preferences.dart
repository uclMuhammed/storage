import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../abstract/storage.dart';

abstract class ImplementSharedPreferences extends IStorage {
  @override
  Future<bool> containsKey(String key) async {
    final value = await read(key);
    return value != null;
  }
}

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  factory SharedPreferencesManager() {
    return _instance;
  }

  SharedPreferencesManager._internal();

  // Token kaydetme
  Future<void> setToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  // Token okuma
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  // Token silme
  Future<void> removeToken() async {
    await _secureStorage.delete(key: 'token');
  }

  // Tüm verileri silme
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  Future<void> setRefreshToken(String token) async {
    await _secureStorage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> clearAllTokens() async {
    await removeToken();
    await _secureStorage.delete(key: 'refresh_token');
  }
}
