import 'package:dio/dio.dart';

class HTTPConfig {
  static const String baseURL = 'http://18.132.161.50/taskou/';
  static const String userBaseURL =
      'http://18.132.161.50/taskou/index.php/api/User/';
  static const String imageBaseURL = 'http://18.132.161.50/taskou/';
  static const String imageBaseVehicleURL =
      'http://18.132.161.50/taskou/uploads/';
  static const String handymanbaseURL =
      'http://18.132.161.50/taskou/index.php/api/Handyman/';

  HTTPConfig(
    BaseOptions options,
  ) {
    options.baseUrl = _getBaseURL(options.baseUrl);
  }

  String _getBaseURL(String baseUrl) {
    if (baseUrl != '') {
      return baseUrl;
    }
    return baseURL;
  }
}
