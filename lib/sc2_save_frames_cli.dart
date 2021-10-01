import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

class Sc2SaveFrames extends Command {
  @override
  final name = 'sc2SaveFrames';

  @override
  final description = 'THETA SC2 save frames from live preview stream';

  Sc2SaveFrames() {
    argParser
      ..addOption('frames', help: '--frames=5')
      ..addOption('delay', help: '--delay=1000  : for 1000ms');
  }

  @override
  void run() async {
    int frames = 5;
    int delay = 0;
    if (argResults != null) {
      if (argResults!.wasParsed('frames')) {
        frames = int.parse((argResults!['frames']));
        if (frames < 1) {
          print('frames must be 1 or higher');
          exit(1);
        }
      }
      if (argResults!.wasParsed('delay')) {
        delay = int.parse((argResults!['delay']));
        if (delay < 34) {
          delay = 34;
          print('setting to minimum delay of 34ms');
        }
      }
    }
    StreamController<List<int>> controller = StreamController();
    List<File> listOfFiles = [];

    for (var i = 1; i < frames + 1; i++) {
      File tempFile =
          await File('theta_frames/sc2_frame_$i.jpg').create(recursive: true);
      listOfFiles.add(tempFile);
    }
    var frameCount = 0;
    Sc2Preview.getLivePreview(
        frames: frames, frameDelay: delay, controller: controller);
    controller.stream.listen((frame) {
      listOfFiles[frameCount].writeAsBytes(frame);
      frameCount++;
    });
  }
}
