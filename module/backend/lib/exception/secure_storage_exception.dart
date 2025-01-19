import '../abstract/exception.dart';

class SecureStorageException extends IException {
  SecureStorageException({
    required super.message,
    required super.statusCode,
    required super.stackTrace,
    super.name,
    super.operation,
    super.type,
    super.metaData,
  });
}
