import 'models.dart';
import 'service.dart';

abstract class IApiService<T extends IModel> extends IService<T> {
  IApiService({
    required super.endPoint,
    required super.baseUrl,
    super.header,
  });

  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<T> create(T model);
  Future<T> updateById(int id, T model);
  Future<bool> deleteById(int id);
  //
}
