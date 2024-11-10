import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;

import '../base/client.dart';
import '../exception/http_custom_exception.dart';

class HttpClientManager extends BaseClient<Http.Response> {
  //
  HttpClientManager(super.baseUrl, super.header);
  //
  @override
  Future<Http.Response> getAll(String endPoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint');
      //
      final response = await Http.get(uri, headers: header);
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Http.Response> getById(String endPoint, {required int id}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint/$id');
      //
      final response = await Http.get(uri, headers: header);
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Http.Response> post(String endPoint,
      {required Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint');
      //
      final encodeBody = jsonEncode(body);
      //
      final response = await Http.post(
        uri,
        headers: header,
        body: encodeBody,
      );
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Http.Response> putById(String endPoint,
      {required int id, required Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint/$id');
      //
      final response = await Http.put(uri, headers: header, body: body);
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Http.Response> deleteById(String endPoint, {required int id}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint/$id');
      //
      final response = await Http.delete(uri, headers: header);
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  //-------------------------------------------------------------------
  Http.Response _handleResponse(Http.Response response) {
    //
    if (kDebugMode) print('Response: ${response.body}');
    //
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw HttpCustomException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
  }

  Exception _handleError(dynamic error) {
    //
    if (kDebugMode) print('Error: $error');
    //
    if (error is HttpCustomException) return error;
    //
    return HttpCustomException(
      statusCode: 500,
      message: 'Internal Server Error',
    );
  }
}
