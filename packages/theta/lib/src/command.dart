import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:theta/theta.dart';

const Map<String, dynamic> emptyBody = {};

/// baseName is 'takePicture', not 'camera.takePicture'
Future<dynamic> command(String baseName,
    {Map<String, dynamic> parameters = emptyBody,
    ResponseType responseType = ResponseType.json}) async {
  var response = await ThetaBase.post('commands/execute',
      responseType: responseType,
      body: {
        'name': 'camera.$baseName',
        'parameters': jsonEncode(
          parameters,
        )
      });

  return response;
}
