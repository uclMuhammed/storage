import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../abstract/models.dart';
import '../abstract/service_api.dart';
import '../exception/http_custom_exception.dart';

class ServiceApiClient<T extends IModel> extends IApiService<T> {
  final T Function(Map<String, dynamic> json) fromJson;
  //
  ServiceApiClient({
    required super.baseUrl,
    required super.endPoint,
    super.header,
    required this.fromJson,
  });
  //

  @override
  Future<List<T>> getAll() async {
    try {
      final response = await client.get(url, headers: header);
      //
      return _handlerResponse<List<T>>(response);
      //
    } catch (e) {
      throw handlerException(e, message: 'Failed to get all data');
    }
  }

  @override
  Future<T> getById(int id) async {
    try {
      final response = await client.get(urlWithId(id), headers: header);
      //
      return _handlerResponse<T>(response);
      //
    } catch (e) {
      throw handlerException(e, message: 'Failed to get data by id');
    }
  }

  @override
  Future<T> create(T model) async {
    try {
      final response = await client.post(
        url,
        headers: header,
        body: model.encodedJson(),
      );
      //
      return _handlerResponse<T>(response);
      //
    } catch (e) {
      throw handlerException(e, message: 'Failed to create data');
    }
  }

  @override
  Future<T> updateById(int id, T model) async {
    try {
      final response = await client.put(
        urlWithId(id),
        headers: header,
        body: model.encodedJson(),
      );
      //
      return _handlerResponse<T>(response);
      //
    } catch (e) {
      throw handlerException(e, message: 'Failed to update data');
    }
  }

  @override
  Future<bool> deleteById(int id) async {
    try {
      final response = await client.delete(
        urlWithId(id),
        headers: header,
      );
      //
      return _handlerResponse<bool>(response);
      //
    } catch (e) {
      throw handlerException(e, message: 'Failed to delete data');
    }
  }

  R _handlerResponse<R>(http.Response response) {
    if (kDebugMode) {
      print('Service API Client');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (R is List) {
        final decoded = json.decode(response.body) as List;
        if (kDebugMode) {
          print('Decoded: $decoded');
        }
        return decoded.map((e) => fromJson(e)).toList() as R;
      } else {
        if (kDebugMode) {
          print('Decoded: ${json.decode(response.body)}');
        }
        return json.decode(response.body) as R;
      }
    } else {
      throw HttpCustomException(
        message: response.body,
        statusCode: response.statusCode,
        stackTrace: StackTrace.current,
        name: 'Service Api Client',
        operation: 'Handler Response',
        type: 'Check',
        metaData: {
          'response': response.toString(),
        },
      );
    }
  }
}
