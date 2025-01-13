import 'package:backend/const/keys.dart';
import 'package:backend/exception/auth_controller_exception.dart';
import 'package:backend/implement/secure_storage.dart';

class ServiceAuthController {
  late final ServiceSecureStorage? _secureStorage;

  static final ServiceAuthController _singleton =
      ServiceAuthController._internal();

  factory ServiceAuthController() {
    return _singleton;
  }

  ServiceAuthController._internal();
  //
  Future<bool> get checkHasUser async {
    try {
      if (_secureStorage == null) {
        _secureStorage = ServiceSecureStorage();
        await _secureStorage?.init();
      }
      //
      final bool? token = await _secureStorage?.read(BearerTokenKey);
      //
      return token ?? false;
    } catch (e) {
      throw AuthControllerException(
        message: 'Check Has User Error',
        statusCode: 500,
        stackTrace: StackTrace.current,
        name: 'ServiceAuthController',
        operation: 'CheckHasUser',
        type: 'GET',
        metaData: {
          'error': e.toString(),
        },
      );
    }
  }
}
