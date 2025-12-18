# Real-Time Pose Detection

Flutter app that detects human poses in real-time using Google ML Kit. Built for the DeepSport job application.

## Features

- Real-time pose detection at 30 FPS
- 33 landmark detection with skeletal overlay
- DeepSport brand colors (Dark Navy + Lime Green)
- Responsive design for all screen sizes

## Tech Stack

- Flutter + Google ML Kit Pose Detection
- Camera package for real-time video
- CustomPainter for overlay rendering
- Simple setState state management

## Installation

### From APK
1. Download `app-release.apk` at https://drive.google.com/file/d/1r3hD9iKeH3YI8Uml-J1Lf71wWB_Mrfwh/view?usp=sharing
2. Install on Android device (Android 5.0+)
3. Grant camera permission

### From Source
```bash
flutter pub get
flutter run
```

## Usage

1. Tap "Start Detection"
2. Stand 1-3 meters from camera
3. Lime green skeleton tracks your movements


## Performance

- 30 FPS real-time detection
- 81.6 MB APK size
- Works at 1-3 meters distance

**Built for DeepSport**
