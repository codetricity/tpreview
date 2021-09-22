import 'package:args/command_runner.dart';
import 'package:theta/theta.dart';

///  POST command to http://192.168.1.1/osc/commands/execute
class ListFiles extends Command {
  @override
  final name = 'listFiles';

  @override
  final description = 'list video and image files on camera';

  ListFiles() {
    argParser
      ..addOption('fileType', help: '--fileType=all | image | video')
      ..addOption('entryCount', help: '--entryCount=20')
      ..addOption('maxThumbSize',
          help: '--maxThumbSize=640 to show thumbs | 0 for no thumbs');
  }

  @override
  void run() async {
    // these three parameters are required
    String fileType = 'all';
    int entryCount = 10;
    int maxThumbSize = 0;

    if (argResults != null) {
      if (argResults!.wasParsed('fileType')) {
        fileType = argResults!['fileType'];
      }
      if (argResults!.wasParsed('entryCount')) {
        entryCount = int.parse(argResults!['entryCount']);
      }
      if (argResults!.wasParsed('maxThumbSize')) {
        maxThumbSize = int.parse(argResults!['maxThumbSize']);
      }
    } else {
      print('argResults is null');
    }
    String response = await command('listFiles', parameters: {
      'fileType': fileType,
      'entryCount': entryCount,
      'maxThumbSize': maxThumbSize
    });
    print(response);
  }
}
