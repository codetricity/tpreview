import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

class PrintFrames extends Command {
  @override
  final name = 'printFrames';

  @override
  final description = 'print frame bytes to console for testing';

  PrintFrames() {
    argParser
      ..addOption('frames', help: '--frames=5 | -1 for infinite')
      ..addOption('delay', help: '--delay=1000  : for 1000ms')
      ..addOption('duration', help: ' in seconds --duration=20');
  }

  @override
  void run() async {
    int frames = 5;
    int delay = 0;
    int duration = -1;
    if (argResults != null) {
      if (argResults!.wasParsed('frames')) {
        frames = int.parse((argResults!['frames']));
      }
      if (argResults!.wasParsed('duration')) {
        duration = int.parse((argResults!['duration']));
      }
      if (argResults!.wasParsed('delay')) {
        delay = int.parse((argResults!['delay']));
        if (delay < 34) {
          delay = 34;
          print('setting to minimum delay of 34ms');
        }
      }
    }
    Stopwatch durationTimer = Stopwatch();
    durationTimer.start();
    var frameCount = 0;
    if (duration != -1) {
      frames = -1;
    }
    StreamController<List<int>> controller = StreamController();
    Preview.getLivePreview(
        frames: frames, frameDelay: delay, controller: controller);

    controller.stream.listen((frame) {
      print(frame);
      frameCount++;
      if (frames == -1 && duration != -1) {
        if (durationTimer.elapsedMilliseconds > duration * 1000) {
          Preview.stopPreview();
        }
      }
    });
  }
}
