import 'package:args/command_runner.dart';

class BasicTest extends Command {
  @override
  final name = 'basicTest';

  @override
  final description = 'test command for library functionality';

  @override
  void run() async {
    print('Ignore this command. This is a basic test of the Basic class');
  }
}
