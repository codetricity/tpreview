import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

///  POST command to http://192.168.1.1/osc/commands/execute
class TakePicture extends Command {
  @override
  final name = 'takePicture';

  @override
  final description =
      'take single still image.  Camera must be in still image mode';

  @override
  void run() async {
    String response = await command('takePicture');
    print(response);
  }
}
