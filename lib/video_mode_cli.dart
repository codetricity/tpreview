import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

///  POST command to http://192.168.1.1/osc/commands/execute
class VideoMode extends Command {
  @override
  final name = 'videoMode';

  @override
  final description = 'Switch camera to video mode';

  @override
  void run() async {
    String response = await setOption(name: 'captureMode', value: 'video');
    print(response);
  }
}
