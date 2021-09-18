import 'dart:convert';

String prettify(String textString) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String dartMap = jsonDecode(textString);
  String output = encoder.convert(dartMap);
  return output;
}
