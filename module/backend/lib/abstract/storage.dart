import '../exception/secure_storage_exception.dart';

abstract class IStorage {
  //
  Future<void> init();
  //
  Future<void> dispose();
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

  Exception handlerException(dynamic error, {String message = ''}) {
    if (error is SecureStorageException) {
      return error;
    }
    return SecureStorageException(
      stackTrace: StackTrace.current,
      message: message + error.toString(),
      statusCode: 500,
    );
  }
}
