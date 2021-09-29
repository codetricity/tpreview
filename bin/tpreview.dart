import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:tpreview/image_mode_cli.dart';
import 'package:tpreview/info.dart';
import 'package:tpreview/interval_shoot.dart';
import 'package:tpreview/list_files_cli.dart';
import 'package:tpreview/preview_format_cli.dart';
import 'package:tpreview/print_frames_cli.dart';
import 'package:tpreview/save_frames_cli.dart';
import 'package:tpreview/save_frames_old_cli.dart';
import 'package:tpreview/sc2_save_frames_cli.dart';
import 'package:tpreview/set_option_cli.dart';
import 'package:tpreview/state.dart';
import 'package:tpreview/take_picture.dart';
import 'package:tpreview/take_picture_ready.dart';
import 'package:tpreview/video_mode_cli.dart';
import 'package:tpreview/check_for_idle_cli.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner('tpreview', 'RICOH THETA Live Preview tester')
    ..addCommand(Info())
    ..addCommand(State())
    ..addCommand(TakePicture())
    ..addCommand(SaveFrames())
    ..addCommand(VideoMode())
    ..addCommand(SetOption())
    // ..addCommand(BasicTest())
    ..addCommand(ImageMode())
    ..addCommand(PreviewFormat())
    ..addCommand(ListFiles())
    ..addCommand(TakePictureReady())
    ..addCommand(CheckForIdle())
    ..addCommand(IntervalShoot())
    ..addCommand(PrintFrames())
    ..addCommand(Sc2SaveFrames());

  await runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}
