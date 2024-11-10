import 'client.dart';
import 'storage.dart';

abstract class BaseAuthService<T> {
  String? endPoint;
  BaseClient? client;
  BaseStorage? storage;
  //
  BaseAuthService({
    required this.endPoint,
    required this.client,
    required this.storage,
  });
  //
  Future<bool> login({
    required int companyCode,
    required String email,
    required String password,
  });
  Future<bool> register({
    required String companyName,
    required String email,
    required String password,
  });
  Future<bool> logout();
  //
  Future<void> init();
  Future<void> dispose();
}
