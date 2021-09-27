import 'dart:async';

import 'package:dio/dio.dart';
import '../theta.dart';

/// get motionJPEG video data from RICOH THETA
/// returns a stream
/// frames = 5 will return 5 frames
/// you must pass getLivePreview a StreamController to
/// manage the return stream
/// Example of listening to the return stream and writing
/// bytes to file:
///   StreamController<List<int>> controller = StreamController();
///   await getLivePreview(controller, frames: frames);
///  controller.stream.listen((frame) {
///    listOfFiles[frameCount].writeAsBytes(frame);
///    frameCount++;
///  });
Future<void> getLivePreview(StreamController controller,
    {int frames = 5}) async {
  var response =
      await command('getLivePreview', responseType: ResponseType.stream);

  Stream dataStream = response.data.stream;

  List<int> buffer = [];
  int startIndex = -1;
  int endIndex = -1;
  int frameCount = 0;
  bool keepRunning = true;
  // bool skipFrame = false;

  // Stopwatch delayTimer = Stopwatch();
  // delayTimer.start();

  StreamSubscription? subscription;
  subscription = dataStream.listen((chunkOfStream) {
    if (frameCount >= frames + 1) {
      if (subscription != null) {
        subscription.cancel();
        keepRunning = false;
        controller.close();
      }
    }
    if (keepRunning) {
      buffer.addAll(chunkOfStream);
      // print('current chunk of stream is ${chunkOfStream.length}');

      for (var i = 0; i < chunkOfStream.length; i++) {
        if (chunkOfStream[i] == 0xff && chunkOfStream[i + 1] == 0xd8) {
          startIndex = i;
        }
        if (chunkOfStream[i] == 0xff && chunkOfStream[i + 1] == 0xd9) {
          endIndex = buffer.length;
        }

        if (startIndex != -1 && endIndex != -1) {
          var frame = buffer.sublist(startIndex, endIndex);
          if (frameCount > 0) {
            controller.add(frame);

            print('framecount $frameCount');
          }
          frameCount++;

          startIndex = -1;
          endIndex = -1;
          buffer = [];
        }
      }
    }
  });
}
