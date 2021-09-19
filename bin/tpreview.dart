import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:tpreview/basic_test.dart';
import 'package:tpreview/info.dart';
import 'package:tpreview/save_frames.dart';
import 'package:tpreview/state.dart';
import 'package:tpreview/take_picture.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner('tpreview', 'RICOH THETA Live Preview tester')
    ..addCommand(Info())
    ..addCommand(State())
    ..addCommand(TakePicture())
    ..addCommand(SaveFrames())
    ..addCommand(BasicTest());

  await runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}
