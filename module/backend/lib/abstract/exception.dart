abstract class IException implements Exception {
  String message;
  StackTrace stackTrace;
  int statusCode;
  //
  String? name;
  String? type;
  String? operation;
  //
  Map<String, dynamic>? metaData;
  //

  IException({
    required this.message,
    required this.statusCode,
    required this.stackTrace,
    //
    this.name,
    this.type,
    this.operation,
    this.metaData,
  });

  @override
  String toString() {
    return 'Exception: $name\n'
        'Type: $type\n'
        'Operation: $operation\n'
        'Message: $message\n'
        'Status Code: $statusCode\n'
        'Meta Data: $metaData\n'
        'Stack Trace: $stackTrace';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'operation': operation,
      'message': message,
      'statusCode': statusCode,
      'metaData': metaData,
      'stackTrace': stackTrace.toString(),
    };
  }
}
