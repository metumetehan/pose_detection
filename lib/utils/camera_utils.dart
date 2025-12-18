import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'dart:typed_data';

/// Utility class for camera image processing and conversion
class CameraUtils {
  /// Converts CameraImage to InputImage format required by ML Kit
  /// Handles image rotation and format conversion
  static InputImage? convertCameraImage(
    CameraImage cameraImage,
    CameraDescription camera,
    int sensorOrientation,
  ) {
    final rotation = rotationIntToImageRotation(sensorOrientation);

    // For Android YUV_420_888, convert to NV21
    if (cameraImage.format.group == ImageFormatGroup.yuv420) {
      return _convertYUV420toNV21(cameraImage, rotation);
    }

    // For iOS BGRA8888
    if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
      final metadata = InputImageMetadata(
        size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.bgra8888,
        bytesPerRow: cameraImage.planes[0].bytesPerRow,
      );

      return InputImage.fromBytes(
        bytes: cameraImage.planes[0].bytes,
        metadata: metadata,
      );
    }

    return null;
  }

  /// Convert YUV420 to NV21 format for ML Kit
  static InputImage _convertYUV420toNV21(
    CameraImage cameraImage,
    InputImageRotation rotation,
  ) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;

    // YUV420 has 3 planes: Y, U, V
    final yPlane = cameraImage.planes[0];
    final uPlane = cameraImage.planes[1];
    final vPlane = cameraImage.planes[2];

    // Calculate sizes
    final int ySize = width * height;
    final int uvWidth = width ~/ 2;
    final int uvHeight = height ~/ 2;
    final int uvPixelStride = uPlane.bytesPerPixel ?? 1;
    final int uvRowStride = uPlane.bytesPerRow;

    // NV21 format: Y plane + interleaved VU plane
    final Uint8List nv21Bytes = Uint8List(ySize + uvWidth * uvHeight * 2);

    // Copy Y plane
    int destIndex = 0;
    for (int row = 0; row < height; row++) {
      final int srcIndex = row * yPlane.bytesPerRow;
      nv21Bytes.setRange(destIndex, destIndex + width, yPlane.bytes, srcIndex);
      destIndex += width;
    }

    // Interleave V and U into NV21 format (VU, not UV!)
    for (int row = 0; row < uvHeight; row++) {
      for (int col = 0; col < uvWidth; col++) {
        final int vIndex = row * uvRowStride + col * uvPixelStride;
        final int uIndex = row * uvRowStride + col * uvPixelStride;
        nv21Bytes[destIndex++] = vPlane.bytes[vIndex];
        nv21Bytes[destIndex++] = uPlane.bytes[uIndex];
      }
    }

    final metadata = InputImageMetadata(
      size: Size(width.toDouble(), height.toDouble()),
      rotation: rotation,
      format: InputImageFormat.nv21,
      bytesPerRow: width,
    );

    return InputImage.fromBytes(
      bytes: nv21Bytes,
      metadata: metadata,
    );
  }

  /// Converts integer rotation value to InputImageRotation enum
  static InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  /// Gets the camera sensor orientation
  static int getSensorOrientation(CameraDescription camera) {
    return camera.sensorOrientation;
  }
}
