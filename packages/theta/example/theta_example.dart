import 'dart:async';
import 'dart:io';
import 'package:theta/theta.dart';

/// save frames to local storage at 4fps

void main() async {
  const int frames = 5;
  // delay in milliseconds between each frame
  // SC2 may have problems if the delay is below 250
  // test with the SC2 upright in a tripod
  const int delay = 250;
  StreamController<List<int>> controller = StreamController();
  List<File> listOfFiles = [];
  for (var i = 1; i < frames + 1; i++) {
    File tempFile =
        await File('theta_frames/theta_frame_$i.jpg').create(recursive: true);
    listOfFiles.add(tempFile);
  }
  var frameCount = 0;
  var preview = Preview(controller);
  await preview.getLivePreview(frames: frames, frameDelay: delay);
  controller.stream.listen((frame) {
    listOfFiles[frameCount].writeAsBytes(frame);
    frameCount++;
  });
}
