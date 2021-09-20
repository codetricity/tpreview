import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

///  POST command to http://192.168.1.1/osc/commands/execute
class ImageMode extends Command {
  @override
  final name = 'imageMode';

  @override
  final description = 'Switch camera to image mode';

  @override
  void run() async {
    String response = await setOption(name: 'captureMode', value: 'image');
    print(response);
  }
}
