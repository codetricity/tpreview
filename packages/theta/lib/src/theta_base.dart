import 'package:dio/dio.dart';

class ThetaBase {
  static final baseUrl = 'http://192.168.1.1/osc/';
  static final headers = 'application/json;charset=utf-8';
  static var dio = Dio();

  static Future<String> get(path) async {
    String url = '$baseUrl$path';
    var response = await dio.get(url);

    return response.toString();
  }
}
