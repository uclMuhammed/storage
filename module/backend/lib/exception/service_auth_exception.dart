import 'package:backend/abstract/exception.dart';

class AuthExceptionOnInit extends IException {
  AuthExceptionOnInit({
    required super.message,
    required super.statusCode,
    required super.stackTrace,
    super.name,
    super.operation,
    super.type,
    super.metaData,
  });
}
