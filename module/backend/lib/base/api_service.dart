import 'client.dart';
import 'storage.dart';

abstract class BaseApiService<T> {
  String endPoint;
  BaseClient? client;
  BaseStorage? storage;
  //
  BaseApiService({
    required this.endPoint,
    this.client,
    this.storage,
  });
  //
  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<T> create(T model);
  Future<T> update(int id, T model);
  Future<bool> delete(int id);
  //
  Future<void> init();
  Future<void> dispose();
}
