import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:theta/theta.dart';
import 'package:dcli/dcli.dart';

/// number of frames to save to file.
/// delay between frames in milliseconds.
/// saveFrames(frames: 5, delay: 1000) will save 5 frames,
/// one per second.
void saveFrames({required int frames, int delay = 0}) async {
  // create theta_images directory if it doesn't exist
  if (!exists('./theta_images')) {
    print('create direction theta_images to store frames');
    createDir('./theta_images');
  }
  var response =
      await command('getLivePreview', responseType: ResponseType.stream);

  var startIndex = -1;
  var endIndex = -1;
  List<int> buf = [];
  bool skipFrame = false;

  List<File> listOfFiles = [];
  int frameCount = 0;
  int totalBytesReceived = 0;

  // start at 1 for the file names only
  for (var i = 1; i < frames + 1; i++) {
    listOfFiles.add(File('theta_images/theta_frame_$i.jpg'));
  }

  bool cancelledSubscription = false;
  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  StreamSubscription? subscription;
  if (response.data?.stream != null) {
    var currentData = response.data?.stream;
    subscription = currentData?.listen((data) {
      if (!cancelledSubscription) {
        int dataLength = data.length;
        totalBytesReceived += dataLength;
        buf.addAll(data);

        for (var i = 0; i < data.length - 1; i++) {
          if (data[i] == 0xFF && data[i + 1] == 0xd8) {
            startIndex = i;
            // print('found frame start');
          }
          if (data[i] == 0xff && data[i + 1] == 0xd9) {
            endIndex = buf.length;
            // print('found frame end');
          }
        }
        if (startIndex != -1 && endIndex != -1) {
          try {
            if (frameCount < frames + 1) {
              if (stopwatch.elapsedMilliseconds > delay) {
                print(
                    'elapsed time (milliseconds): ${stopwatch.elapsedMilliseconds}');
                skipFrame = false;
                stopwatch.stop();
                stopwatch.reset();
                stopwatch.start();
              }

              if (!skipFrame) {
                // skip first frame as it does not seem to be correctly
                // formatted
                if (frameCount != 0) {
                  listOfFiles[frameCount - 1]
                      .writeAsBytes(buf.sublist(startIndex, endIndex));
                }
                print('frame $frameCount');
                print('total bytes received ${totalBytesReceived / 1000000}MB');
                skipFrame = true;
                frameCount++;
              }
            } else {
              cancelledSubscription = true;
              if (subscription != null) {
                subscription.cancel();
              }
            }
          } catch (error) {
            print(error);
          }

          startIndex = -1;
          endIndex = -1;
          buf = [];
        }
      }
    });
  }
}
