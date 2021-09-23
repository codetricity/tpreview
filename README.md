# theta preview tester

Command line tester for RICOH THETA [get live preview API](https://api.ricoh/docs/theta-web-api-v2.1/commands/camera.get_live_preview/).

The tester can also be used to test a subset of common camera commands.

## Usage

```shell
dart tpreview.dart --help        
RICOH THETA Live Preview tester

Usage: tpreview <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  imageMode       Switch camera to image mode
  info            camera information, including model, serial number
  listFiles       list video and image files on camera
  previewFormat   Set preview format
  saveFrames      save frames from live preview stream
  setOption       Set single camera option
  state           camera status, battery level, API version, last file URL
  takePicture     take single still image.  Camera must be in still image mode
  videoMode       Switch camera to video mode

Run "tpreview help <command>" for more information about a command.
```

## Options for saveFrames

```shell
dart .\tpreview.dart saveFrames --help
save frames from live preview stream

Usage: tpreview saveFrames [arguments]
-h, --help      Print this usage information.
    --frames    --frames=5
    --delay     --delay=1000  : for 1000ms

Run "tpreview help" to see global options.
```

As the maximum frame rate is 30fps, the lowest delay between frames is
34 milliseconds.

## Examples

Examples below are with RICOH THETA SC2 with firmware 1.64

### saveFrames

With no options, will save 5 frames at 1 fps.

```shell
tpreview.exe saveFrames
```

![live preview screenshot](docs/images/live_preview_screenshot_1.png)

#### Changing number of frames and delay between frames

Saving 10 frames with a delay of 10 seconds between frames.  10 seconds
is 10000 milliseconds.

Example shown using dart command on uncompiled application in `bin\tpreview.dart`.
Test with SC2 firmware 1.64.

```shell
\tpreview\bin> dart .\tpreview.dart saveFrames --frames=10 --delay 10000
frame 0
total bytes received 0.063492MB
...
```
![live preview screenshot 2](docs/images/live_preview_screenshot_2.png)

In the example above, I am holding the camera up to my computer monitor
to test a moving scene.  I am playing a moving from YouTube on my
computer screen for the motion.

#### Z1 test

With firmware 2.00.1, the test results are the same.

![z1 screenshot](docs/images/z1_live_preview.png)

Each frame can be viewed in a viewer such as FSP Viewer.

![z1 moving screenshot](docs/images/z1_moving_screenshot.gif)

### Setting Resolution and fps with the API

You cannot use the WebAPI to change the resolution or framerate of the SC2.
The API for [previewFormat](https://api.ricoh/docs/theta-web-api-v2.1/options/preview_format/) only works with the V and Z1.

#### Set to 1920x960 @ 8fps

```shell
dart .\tpreview.dart previewFormat --width=1920 --framerate=8
{"name":"camera.setOptions","state":"done"}
```

Save frames and verify.

![frame dimensions 1920x960](docs/images/frame_size.png)

### tpreview state

```json
{
  "fingerprint": "FIG_0003",
  "state": {
    "batteryLevel": 0.8,
    "storageUri": "http://192.168.1.1/files/thetasc26c21a247d9055838792badc5",
    "_apiVersion": 2,
    "_batteryState": "charged",
    "_cameraError": [],
    "_captureStatus": "idle",
    "_capturedPictures": 0,
    "_latestFileUrl": "http://192.168.1.1/files/thetasc26c21a247d9055838792badc5/100RICOH/R0012015.JPG",
    "_recordableTime": 0,
    "_recordedTime": 0,
    "_function": "normal"
  }
}
```

### tpreview takePicture

```json
{
  "id": "68",
  "progress": {
    "completion": 0.0
  },
  "state": "inProgress"
}
```

### dart tpreview.dart info

This example shows how to run the `bin/tpreview.dart` source file instead
of the compiled binary.  The compiled binary will run faster.

```json
{
  "manufacturer": "RICOH",
  "model": "RICOH THETA SC2",
  "serialNumber": "20001005",
  "firmwareVersion": "01.64",
  "supportUrl": "https://theta360.com/en/support/",
  "gps": false,
  "gyro": true,
  "endpoints": {
    "httpPort": 80,
    "httpUpdatesPort": 80
  },
  "apiLevel": [
    2
  ],
  "api": [
    "/osc/info",
    "/osc/state",
    "/osc/checkForUpdates",
    "/osc/commands/execute",
    "/osc/commands/status"
  ],
  "uptime": 3294,
  "_wlanMacAddress": "58:38:79:2b:ad:c5",
  "_bluetoothMacAddress": "6c:21:a2:47:d9:05"
}
```

## Example Compiling for Windows

```shell
dart compile exe --output build/tpreview.exe .\bin\tpreview.dart
Info: Compiling with sound null safety
Generated: c:\users\craig\documents\development\ricoh\livepreview\tpreview\build\tpreview.exe
```

### Usage after compilation

```shell
cd .\build\
.\tpreview.exe info   
```

## conversion to video

Combined frames into movie with editor.

![frames to movie](docs/images/image_to_movie.gif)


## Status

* Sept 19, 2021: tested with Z1 and appears to work fine.
* Sept 18, 2021: live preview save to frames is working with SC2

