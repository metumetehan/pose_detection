import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

/// CustomPainter that draws pose landmarks and connections on the canvas
class PosePainter extends CustomPainter {
  final List<Pose> poses;
  final Size imageSize;
  final Size widgetSize;

  PosePainter({
    required this.poses,
    required this.imageSize,
    required this.widgetSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for drawing joints (circles)
    final jointPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFCAFF33) // Lime green for joints
      ..strokeWidth = 8;

    // Paint for drawing connections (lines)
    final connectionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFCAFF33) // Lime green for connections
      ..strokeWidth = 4;

    // Paint for confidence-based coloring
    final lowConfidencePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.redAccent.withValues(alpha: 0.6)
      ..strokeWidth = 8;

    for (final pose in poses) {
      // Draw all connections between landmarks first (so they appear behind joints)
      _drawConnections(canvas, pose, connectionPaint);

      // Draw all landmarks (joints)
      pose.landmarks.forEach((type, landmark) {
        final point = _scalePoint(
          offset: Offset(
            landmark.x.toDouble(),
            landmark.y.toDouble(),
          ),
        );

        // Use different color based on confidence
        final paint =
            landmark.likelihood > 0.5 ? jointPaint : lowConfidencePaint;

        canvas.drawCircle(point, 8, paint);
      });
    }
  }

  /// Draws connections between pose landmarks to form the skeleton
  void _drawConnections(Canvas canvas, Pose pose, Paint paint) {
    // Helper function to draw a line between two landmarks
    void drawLine(PoseLandmarkType type1, PoseLandmarkType type2) {
      final landmark1 = pose.landmarks[type1];
      final landmark2 = pose.landmarks[type2];

      if (landmark1 != null && landmark2 != null) {
        final point1 = _scalePoint(
          offset: Offset(landmark1.x.toDouble(), landmark1.y.toDouble()),
        );
        final point2 = _scalePoint(
          offset: Offset(landmark2.x.toDouble(), landmark2.y.toDouble()),
        );

        canvas.drawLine(point1, point2, paint);
      }
    }

    // Face
    drawLine(PoseLandmarkType.leftEar, PoseLandmarkType.leftEye);
    drawLine(PoseLandmarkType.leftEye, PoseLandmarkType.nose);
    drawLine(PoseLandmarkType.nose, PoseLandmarkType.rightEye);
    drawLine(PoseLandmarkType.rightEye, PoseLandmarkType.rightEar);

    // Left arm
    drawLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow);
    drawLine(PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist);
    drawLine(PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb);
    drawLine(PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinky);
    drawLine(PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndex);

    // Right arm
    drawLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow);
    drawLine(PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist);
    drawLine(PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb);
    drawLine(PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinky);
    drawLine(PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndex);

    // Body
    drawLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder);
    drawLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip);
    drawLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip);
    drawLine(PoseLandmarkType.leftHip, PoseLandmarkType.rightHip);

    // Left leg
    drawLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee);
    drawLine(PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle);
    drawLine(PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel);
    drawLine(PoseLandmarkType.leftAnkle, PoseLandmarkType.leftFootIndex);

    // Right leg
    drawLine(PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee);
    drawLine(PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle);
    drawLine(PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel);
    drawLine(PoseLandmarkType.rightAnkle, PoseLandmarkType.rightFootIndex);
  }

  /// Scales the point from image coordinates to widget coordinates
  Offset _scalePoint({required Offset offset}) {
    final double scaleX = widgetSize.width / imageSize.width;
    final double scaleY = widgetSize.height / imageSize.height;

    return Offset(
      offset.dx * scaleX,
      offset.dy * scaleY,
    );
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    // Repaint when poses change
    return oldDelegate.poses != poses ||
        oldDelegate.imageSize != imageSize ||
        oldDelegate.widgetSize != widgetSize;
  }
}
