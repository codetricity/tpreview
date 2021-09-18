import 'dart:convert';

import 'package:theta/theta.dart';

/// baseName is 'takePicture', not 'camera.takePicture'
Future<String> command(String baseName, Map<String, dynamic> parameters) async {
  var response = await ThetaBase.post('commands/execute',
      {'name': 'camera.$baseName', 'parameters': jsonEncode(parameters)});

  return response;
}
