abstract class BaseStorage {
  //
  Future<T?> read<T>(String key);
  //
  Future<bool> write<T>(String key, T value);
  //
  Future<bool> update<T>(String key, T value);
  //
  Future<bool> delete(String key);
  //
  Future<bool> clear();
  //
  Future<bool> containsKey(String key);
  //
}
