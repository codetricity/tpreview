import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

void main() async {
  var dio = Dio();
  var url = 'http://192.168.1.1/osc/commands/execute';
  var parsedUrl = Uri.parse(url);
  Map<String, dynamic> body = {
    'name': 'camera.setOptions',
    'parameters': {
      'options': {'captureMode': 'image'}
    }
  };
  var response = await dio.post(url,
      data: jsonEncode(body),
      options:
          Options(headers: {'Content-Type': 'application/json;charset=utf-8'}));
  print(response);

  // var response = await http.post(parsedUrl,
  //     headers: {'Content-Type': 'application/json; charset=utf-8'},
  //     body: jsonEncode(body));
  // print(response.body);
}
