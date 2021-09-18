# theta preview tester

Command line tester for RICOH THETA livePreview.

The tester can also be used to test a subset of common camera commands.

## Usage


```shell
build> .\tpreview.exe help   
RICOH THETA Live Preview tester

Usage: tpreview <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  basicTest     test command for library functionality
  info          camera information, including model, serial number
  state         camera status, battery level, API version, last file URL
  takePicture   take single still image.  Camera must be in still image mode

Run "tpreview help <command>" for more information about a command.
```

## Examples

Examples below are with RICOH THETA SC2 with firmware 1.64

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

### tpreview.dart info

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


