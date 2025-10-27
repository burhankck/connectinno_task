import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:reflectable/reflectable.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:connectinno_task/core/global/result_model.dart';
import 'package:connectinno_task/core/services/network_handler/error_handler.dart';
import 'package:connectinno_task/core/services/network_handler/failure.dart';

import '../../global/reflector.dart' show reflector;



class _JsonHelper {
  static const FROM_JSON = "fromJson";
}

/// Network Api Service
class NetworkApiService {
  static final NetworkApiService _instance = NetworkApiService._internal();
  static NetworkApiService get instance => _instance;
  NetworkApiService._internal();

  dynamic responseJson;
  String? _accessToken;

  void setAccessToken(String token) {
    _accessToken = token;
  }

  Map<String, String> get _defaultHeaders => {
    "Content-Type": "application/json",
    if (_accessToken != null) "Authorization": "Bearer $_accessToken",
  };

  dynamic jsonSerialize(dynamic jsonResponse) => json.decode(jsonResponse);

  /// Generic GET
  Future getApiResponse<T extends BaseResultModel>(
    String baseAddress,
    String path, {
    bool isList = false,
  }) async {
    final url = "$baseAddress$path";
    final classMirror = reflector.reflectType(T) as ClassMirror;

    try {
      final response = await http
          .get(Uri.parse(url), headers: _defaultHeaders)
          .timeout(const Duration(seconds: 30));

      responseJson = jsonSerialize(response.body);

      responseJson = checkStatus<T>(
        body: response.body,
        statusCode: response.statusCode,
        classMirror: classMirror,
        isList: isList,
      );
    } on SocketException {
      throw Failure(
        ResponseCode.NO_INTERNET_CONNECTION,
        ResponseMessage.NO_INTERNET_CONNECTION,
      );
    } on TimeoutException catch (e) {
      throw Failure("Zaman aşımı hatası", e.toString());
    } on Error catch (e) {
      debugPrint("getApiResponse() method error: $e");
      throw Failure(ResponseCode.UNKNOWN, e.toString());
    }
    return responseJson;
  }

  /// Generic POST
  Future postApiResponse<T extends BaseResultModel>(
    String baseAddress,
    String path,
    Map<String, dynamic> data, {
    Object? body,
    bool isList = false,
  }) async {
    final url = "$baseAddress$path";
    final classMirror = reflector.reflectType(T) as ClassMirror;

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _defaultHeaders,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 30));

      responseJson = jsonSerialize(response.body);

      responseJson = checkStatus<T>(
        body: response.body,
        statusCode: response.statusCode,
        classMirror: classMirror,
        isList: isList,
      );
    } on SocketException {
      throw Failure(
        ResponseCode.NO_INTERNET_CONNECTION,
        ResponseMessage.NO_INTERNET_CONNECTION,
      );
    } on TimeoutException catch (e) {
      throw Failure("Zaman aşımı hatası", e.toString());
    } on Error catch (e) {
      debugPrint("postApiResponse() method error: $e");
      throw Failure(ResponseCode.UNKNOWN, e.toString());
    }

    return responseJson;
  }

  /// Generic PUT
  Future putApiResponse<T extends BaseResultModel>(
    String baseAddress,
    String path,
    Map<String, dynamic> data, {
    Object? body,
    bool isList = false,
  }) async {
    final url = "$baseAddress$path";
    final classMirror = reflector.reflectType(T) as ClassMirror;

    try {
      final response = await http
          .put(Uri.parse(url), headers: _defaultHeaders, body: jsonEncode(data))
          .timeout(const Duration(seconds: 30));

      responseJson = jsonSerialize(response.body);

      responseJson = checkStatus<T>(
        body: response.body,
        statusCode: response.statusCode,
        classMirror: classMirror,
        isList: isList,
      );
    } on SocketException {
      throw Failure(
        ResponseCode.NO_INTERNET_CONNECTION,
        ResponseMessage.NO_INTERNET_CONNECTION,
      );
    } on TimeoutException catch (e) {
      throw Failure("Zaman aşımı hatası", e.toString());
    } on Error catch (e) {
      debugPrint("putApiResponse() method error: $e");
      throw Failure(ResponseCode.UNKNOWN, e.toString());
    }

    return responseJson;
  }

  /// Generic DELETE
  Future deleteApiResponse<T extends BaseResultModel>(
    String baseAddress,
    String path, {
    bool isList = false,
  }) async {
    final url = "$baseAddress$path";
    final classMirror = reflector.reflectType(T) as ClassMirror;

    try {
      final response = await http
          .delete(Uri.parse(url), headers: _defaultHeaders)
          .timeout(const Duration(seconds: 30));

      if (response.body.isNotEmpty) {
        responseJson = jsonSerialize(response.body);
      }

      responseJson = checkStatus<T>(
        body: response.body,
        statusCode: response.statusCode,
        classMirror: classMirror,
        isList: isList,
      );
    } on SocketException {
      throw Failure(
        ResponseCode.NO_INTERNET_CONNECTION,
        ResponseMessage.NO_INTERNET_CONNECTION,
      );
    } on TimeoutException catch (e) {
      throw Failure("Zaman aşımı hatası", e.toString());
    } on Error catch (e) {
      debugPrint("deleteApiResponse() method error: $e");
      throw Failure(ResponseCode.UNKNOWN, e.toString());
    }

    return responseJson;
  }

  /// Convert JSON to object
  T? jsonToObject<T>({required var classMirror, dynamic body}) {
    if (body == null) return null;
    if (body is String) body = jsonDecode(body);
    return classMirror.newInstance(_JsonHelper.FROM_JSON, [body]);
  }

  List<T>? jsonToObjectList<T>({required var classMirror, dynamic body}) {
    if (body == null) return null;
    if (body is String) body = jsonDecode(body);

    final listResponse = <T>[];
    if (body is List) {
      for (var item in body) {
        _jsonToModel<T>(classMirror, item, listResponse);
      }
    } else {
      _jsonToModel<T>(classMirror, body, listResponse);
    }
    return listResponse;
  }

  void _jsonToModel<T>(var classMirror, dynamic item, List<T> listResponse) {
    final T responsChildValue = classMirror.newInstance(_JsonHelper.FROM_JSON, [
      item,
    ]);
    listResponse.add(responsChildValue);
  }

  /// Status kontrolü
  dynamic checkStatus<T extends BaseResultModel>({
    required int statusCode,
    required String body,
    required bool isList,
    required ClassMirror classMirror,
  }) {
    if (statusCode == HttpStatus.ok ||
        statusCode == HttpStatus.created ||
        statusCode == HttpStatus.noContent) {
      if (statusCode == HttpStatus.noContent) {
        return null; // veya ResponseMessage.NO_CONTENT döndür
      }
      return isList
          ? jsonToObjectList<T>(classMirror: classMirror, body: body)
          : jsonToObject<T>(classMirror: classMirror, body: body);
    }

    switch (statusCode) {
      case HttpStatus.notFound: // 404
        throw DataSource.NOT_FOUND.getFailure();
      case HttpStatus.badRequest: // 400
        throw DataSource.BAD_REQUEST.getFailure();
      case HttpStatus.unauthorized: // 401
        throw DataSource.UNAUTHORISED.getFailure();
      case HttpStatus.forbidden: // 403
        throw DataSource.FORBIDDEN.getFailure();
      case HttpStatus.internalServerError: // 500
        throw DataSource.INTERNAL_SERVER_ERROR.getFailure();
      default:
        throw DataSource.UNKNOWN.getFailure();
    }
  }
}
