import 'dart:convert';

import '../theta.dart';

/// status of command. Returns "done", "inProgress", or "error"
Future<String> commandStatus(String id) async {
  var response = await ThetaBase.post('commands/status', body: {'id': id});
  await Future.delayed(Duration(milliseconds: 100));
  Map<String, dynamic> responseMap = jsonDecode(response);

  return responseMap['state'];
}
