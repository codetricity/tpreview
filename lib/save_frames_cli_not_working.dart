import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

class SaveFrames extends Command {
  @override
  final name = 'saveFrames';

  @override
  final description = 'save frames from live preview stream';

  SaveFrames() {
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
      }
      if (argResults!.wasParsed('delay')) {
        delay = int.parse((argResults!['delay']));
        if (delay < 34) {
          delay = 34;
        }
      }
    }
    StreamController<List<int>> controller = StreamController();
    List<File> listOfFiles = [];
    for (var i = 1; i < frames + 1; i++) {
      File tempFile =
          await File('theta_frame/theta_frame_$i.jpg').create(recursive: true);
      listOfFiles.add(tempFile);
    }
    var frameCount = 0;
    await getLivePreview(controller, frames: frames);
    controller.stream.listen((frame) {
      listOfFiles[frameCount].writeAsBytes(frame);
      frameCount++;
    });
  }
}
