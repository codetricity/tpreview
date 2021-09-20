import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

///  POST command to http://192.168.1.1/osc/commands/execute
class SetOption extends Command {
  @override
  final name = 'setOption';

  @override
  final description = 'Set single camera option';

  SetOption() {
    argParser
      ..addOption('name', help: '--name=captureMode')
      ..addOption('value', help: '--value=image');
  }

  @override
  void run() async {
    if (argResults != null) {
      if (argResults!.arguments.isEmpty) {
        printUsage();
      } else if (argResults!.wasParsed('name') &&
          argResults!.wasParsed('value')) {
        String response = await setOption(
            name: argResults!['name'], value: argResults!['value']);
        print(response);
      } else {
        printUsage();
      }
    }
  }
}
