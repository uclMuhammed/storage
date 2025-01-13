import '../abstract/storage.dart';

abstract class ImplementSharedPreferences extends IStorage {
  @override
  Future<bool> containsKey(String key) async {
    final value = await read(key);
    return value != null;
  }
}
