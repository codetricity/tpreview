import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

class SaveFrames extends Command {
  @override
  final name = 'saveFrames';

  @override
  final description = 'save frames from live preview stream';

  @override
  void run() async {
    saveFrames(frames: 5, delay: 1000);
  }
}
