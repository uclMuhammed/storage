abstract class BaseClient<T> {
  final String baseUrl;
  final Map<String, String> header;
  //
  BaseClient(this.baseUrl, this.header);

  Future<T> getAll(String endPoint);
  //
  Future<T> getById(String endPoint, {required int id});
  //
  Future<T> post(String endPoint, {required Map<String, dynamic> body});
  //
  Future<T> put(String endPoint, {required Map<String, dynamic> body});
  //
  Future<T> putById(
    String endPoint, {
    required int id,
    required Map<String, dynamic> body,
  });
  //
  Future<T> delete(String endPoint);
  //
  Future<T> deleteById(String endPoint, {required int id});
}
