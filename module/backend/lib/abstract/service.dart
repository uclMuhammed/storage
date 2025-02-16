import 'package:http/http.dart' as http;
import '../exception/http_custom_exception.dart';

abstract class IService<T> {
  final String baseUrl;
  final String endPoint;
  Map<String, String>? header;
  late http.Client _client;

  IService({
    required this.endPoint,
    required this.baseUrl,
    this.header,
  });

  http.Client get client => _client;

  Future<void> init() async {
    try {
      _client = http.Client();
    } catch (e) {
      throw Exception('Failed to initialize client');
    }
  }

  Future<void> dispose() async {
    try {
      _client.close();
    } catch (e) {
      throw Exception('Failed to close client');
    }
  }

  Exception handlerException(dynamic error, {String message = ''}) {
    if (error is HttpCustomException) {
      return error;
    }
    throw HttpCustomException(
      message: message + error.toString(),
      statusCode: 500,
      stackTrace: StackTrace.current,
    );
  }

  Uri get url => Uri.parse('$baseUrl$endPoint');
  Uri urlWithId(int id) => Uri.parse('$baseUrl$endPoint/$id');
}
