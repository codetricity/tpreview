import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:theta/theta.dart' as theta;

///  Show when camera is ready for next command
class TakePictureReady extends Command {
  @override
  final name = 'takePictureReady';

  @override
  final description =
      'take single still image and show when camera is ready for next command';

  @override
  void run() async {
    String response = await theta.command('takePicture');
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    if (!response.contains('error')) {
      Map<String, dynamic> responseMap = jsonDecode(response);
      String id = responseMap['id'];
      Stopwatch progressUpdateTimer = Stopwatch();
      progressUpdateTimer.start();
      while (await theta.commandStatus(id) != 'done') {
        await theta.commandStatus(id);
        if (progressUpdateTimer.elapsedMilliseconds > 1000) {
          progressUpdateTimer.reset();
          print(
              'In progress after: ${stopwatch.elapsedMilliseconds} milliseconds');
        }
      }
      stopwatch.stop();
      int elapsedTime = stopwatch.elapsedMilliseconds;
      print('ready for next command after $elapsedTime milliseconds');
    } else {
      print(response);
    }
  }
}
