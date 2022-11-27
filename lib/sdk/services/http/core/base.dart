import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

import '../../../../sdk/sdk.dart';
import '../../../../app/app.dart';
import '../../../../configs/configs.dart';

class DioBase extends HTTPConfig implements HTTP {
  BaseOptions options;
  late Dio dio;

  DioBase({
    required this.options,
  }) : super(options) {
    dio = Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
      );
      return _handleDioResponse(response);
    } on DioError catch (e) {
      String errorMessage = _handleDioError(
        e,
      );
      throw NetworkException(
        errorMessage,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleDioResponse(response);
    } on DioError catch (e) {
      String errorMessage = _handleDioError(
        e,
      );
      throw NetworkException(
        errorMessage,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  @override
  Future<dynamic> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response response = await dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  dynamic _handleDioResponse(
    Response response,
  ) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          if (response.data is String) {
            return jsonDecode(response.data);
          }
        } catch (_) {}
        return response.data;
      default:
        throw NetworkException(
          'Error occurred: ${response.statusCode}',
        );
    }
  }

  String _handleDioError(
    DioError e,
  ) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        return 'Connection timeout';
      case DioErrorType.sendTimeout:
        return 'Sent timeout';
      case DioErrorType.receiveTimeout:
        return 'Receive timeout';
      case DioErrorType.response:
        try {
          if (e.response?.statusCode == 417) {
            if (e.response?.data != null) {
              var response = e.response?.data;
              if (response['_server_messages'] != null) {
                List? messages =
                    jsonDecode(e.response?.data['_server_messages']);
                if (messages != null && messages.isNotEmpty) {
                  String? message = jsonDecode(messages.first)['message'];
                  if (message != null && message.isNotEmpty) {
                    return message;
                  }
                }
              }
            }
          } else if (e.response?.toString().contains('ValidationError') ==
              true) {
            if (e.response?.data != null) {
              var response = e.response?.data;
              if (response['_server_messages'] != null) {
                List? messages = jsonDecode(response['_server_messages']);
                if (messages != null && messages.isNotEmpty) {
                  String? message = jsonDecode(messages.last)['message'];
                  if (message != null && message.isNotEmpty) {
                    return message;
                  }
                }
              }
            }
          }
        } catch (e) {}
        return e.response?.data['message'] ?? e.message ?? 'Error from server';
      case DioErrorType.cancel:
        return 'Request cancelled';
      case DioErrorType.other:
        if (e.error != null) {
          return e.error;
        }
        return 'Error from server';
    }
  }
}
