import '../abstract/exception.dart';

class HttpCustomException extends IException {
  HttpCustomException({
    required super.message,
    required super.statusCode,
    required super.stackTrace,
    super.name,
    super.operation,
    super.type,
    super.metaData,
  });
}
