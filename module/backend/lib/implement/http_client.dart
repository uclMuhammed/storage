import 'dart:convert';

import 'package:backend/const/headers.dart';
import 'package:backend/const/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../base/client.dart';
import '../exception/http_custom_exception.dart';

class HttpClientManager extends BaseClient<http.Response> {
  //
  HttpClientManager(super.baseUrl, super.header);
  //
  @override
  Future<http.Response> getAll(String endPoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint');
      //
      final response = await http.get(uri, headers: header);
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<http.Response> getById(String endPoint, {required int id}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint/$id');
      //
      final response = await http.get(uri, headers: header);
      //
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<http.Response> post(String endPoint,
      {required Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint');

      // Debug için URL ve body bilgilerini yazdır
      if (kDebugMode) {
        print('Base URL: $baseUrl');
        print('Endpoint: $endPoint');
        print('Full URL: ${uri.toString()}');
        print('Headers: $header');
        print('Request Body: ${jsonEncode(body)}');
      }

      final response = await http.post(
        uri,
        headers: header,
        body: jsonEncode(body),
      );

      // Response detaylarını yazdır
      if (kDebugMode) {
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');
        print('Response Headers: ${response.headers}');
      }

      return _handleResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print('POST Error: $e');
      }
      throw _handleError(e);
    }
  }

  @override
  Future<http.Response> put(String endPoint,
      {required Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint');

      if (kDebugMode) {
        print('PUT Request URL: $uri');
        print('PUT Request Headers: $header');
        print('PUT Request Body: $body');
      }

      final response = await http.put(
        uri,
        headers: header,
        body: jsonEncode(body),
      );

      if (kDebugMode) {
        print('PUT Response Status: ${response.statusCode}');
        print('PUT Response Body: ${response.body}');
      }

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<http.Response> putById(String endPoint,
      {required int id, required Map<String, dynamic> body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint/$id');

      if (kDebugMode) {
        print('PUT Request URL: $uri');
        print('PUT Request Headers: $header');
        print('PUT Request Body: $body');
      }

      final response = await http.put(
        uri,
        headers: header,
        body: jsonEncode(body),
      );

      if (kDebugMode) {
        print('PUT Response Status: ${response.statusCode}');
        print('PUT Response Body: ${response.body}');
      }

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<http.Response> delete(String endPoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint');

      if (kDebugMode) {
        print('Delete Request URL: $uri');
        print('Base URL: $baseUrl');
        print('Endpoint: $endPoint');
        print('Full URL: $uri');
      }

      final response = await http.delete(uri, headers: header);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<http.Response> deleteById(String endPoint, {required int id}) async {
    try {
      final uri = Uri.parse('$baseUrl$endPoint/$id');

      if (kDebugMode) {
        print('Delete Request URL: $uri');
        print('Base URL: $baseUrl');
        print('Endpoint: $endPoint');
        print('Full URL: $uri');
      }

      final response = await http.delete(uri, headers: header);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  //-------------------------------------------------------------------
  http.Response _handleResponse(http.Response response) {
    //
    if (kDebugMode) {
      print('HttpClientManager Handle Response: ${response.body}');
    }
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

HttpClientManager stockTrackerApiClient(String token) => HttpClientManager(
      StockTrackerApiUrl,
      HeaderWithToken(token),
    );

HttpClientManager stockTrackerAuthClient = HttpClientManager(
  StockTrackerAuthUrl,
  StockTrackerAuthHeader,
);
