import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

/// basic POST command to http://192.168.1.1/osc/state
class State extends Command {
  @override
  final name = 'state';

  @override
  final description =
      'camera status, battery level, API version, last file URL';

  @override
  void run() async {
    String response = await ThetaBase.post('state');
    print(response);
  }
}
