import 'storage.dart';

abstract class BaseSharedPreferences implements BaseStorage {
  @override
  Future<bool> containsKey(String key) async {
    final value = await read(key);
    return value != null;
  }
}
