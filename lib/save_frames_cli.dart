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
    int delay = 1000;
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
    saveFrames(frames: frames, delay: delay);
  }
}
