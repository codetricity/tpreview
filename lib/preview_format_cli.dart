import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

///  POST command to http://192.168.1.1/osc/commands/execute
class PreviewFormat extends Command {
  @override
  final name = 'previewFormat';

  @override
  final description = 'Set preview format';

  PreviewFormat() {
    argParser
      ..addOption('width', help: '--width=1920 or [1024 | 640]')
      ..addOption('framerate', help: '--framerate=8 or [30]');
  }

  @override
  void run() async {
    if (argResults != null) {
      if (argResults!.arguments.isEmpty) {
        printUsage();
      } else if (argResults!.wasParsed('width') &&
          argResults!.wasParsed('framerate')) {
        int width = int.parse(argResults!['width']);
        int height = (width / 2).round();
        int framerate = int.parse(argResults!['framerate']);
        Map<String, dynamic> previewFormatMap = {
          'width': width,
          'height': height,
          'framerate': framerate
        };
        String response =
            await setOption(name: 'previewFormat', value: previewFormatMap);
        print(response);
      } else {
        printUsage();
      }
    }
  }
}
