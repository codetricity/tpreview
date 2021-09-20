import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

class Info extends Command {
  @override
  final name = 'info';

  @override
  final description = 'camera information, including model, serial number';

  @override
  void run() async {
    String response = await ThetaBase.get('info');
    print(response);
  }
}
