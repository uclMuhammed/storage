import '../abstract/exception.dart';

class AuthControllerException extends IException {
  AuthControllerException({
    required super.message,
    required super.statusCode,
    required super.stackTrace,
    super.name,
    super.operation,
    super.type,
    super.metaData,
  });
}
