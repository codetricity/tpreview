import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

class CheckForIdle extends Command {
  @override
  final name = 'checkForIdle';

  @override
  final description =
      'wait for camera to be idle after startCapture or self timer for next command';

  @override
  void run() async {
    String response = await checkForIdle();
    print(response);
  }
}
