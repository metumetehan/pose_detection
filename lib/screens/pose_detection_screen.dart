import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import '../painters/pose_painter.dart';
import '../utils/camera_utils.dart';

class PoseDetectionScreen extends StatefulWidget {
  const PoseDetectionScreen({super.key});

  @override
  State<PoseDetectionScreen> createState() => _PoseDetectionScreenState();
}

class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
  CameraController? _cameraController;
  PoseDetector? _poseDetector;
  bool _isDetecting = false;
  List<Pose> _poses = [];
  Size _imageSize = Size.zero;
  bool _isInitialized = false;
  String _status = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  /// Initialize camera and pose detector
  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        setState(() {
          _status = 'Camera permission denied';
        });
        return;
      }

      // Get available cameras
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _status = 'No cameras available';
        });
        return;
      }

      // Use back camera (index 0 is usually back camera)
      final camera = cameras.first;

      // Initialize camera controller with medium resolution for performance
      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420, // Required for ML Kit
      );

      await _cameraController!.initialize();

      // Initialize pose detector in stream mode
      final options = PoseDetectorOptions(
        mode: PoseDetectionMode.stream,
      );
      _poseDetector = PoseDetector(options: options);

      // Start image stream for real-time detection
      _cameraController!.startImageStream(_processCameraImage);

      setState(() {
        _isInitialized = true;
        _status = 'Ready';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }

  /// Process each camera frame for pose detection
  Future<void> _processCameraImage(CameraImage image) async {
    // Skip if already processing (prevents UI freezing)
    if (_isDetecting) return;

    _isDetecting = true;

    try {
      // Convert CameraImage to InputImage
      final inputImage = CameraUtils.convertCameraImage(
        image,
        _cameraController!.description,
        CameraUtils.getSensorOrientation(_cameraController!.description),
      );

      if (inputImage == null) {
        if (mounted) {
          setState(() {
            _status = 'Image conversion failed';
          });
        }
        _isDetecting = false;
        return;
      }

      // Detect poses
      final poses = await _poseDetector!.processImage(inputImage);

      // Update image size for scaling
      // Account for rotation: swap width/height for 90° and 270° rotations
      final sensorOrientation = CameraUtils.getSensorOrientation(_cameraController!.description);
      final needsSwap = sensorOrientation == 90 || sensorOrientation == 270;

      _imageSize = needsSwap
          ? Size(
              image.height.toDouble(),
              image.width.toDouble(),
            )
          : Size(
              image.width.toDouble(),
              image.height.toDouble(),
            );

      // Update UI with detected poses
      if (mounted) {
        setState(() {
          _poses = poses;
          if (poses.isEmpty) {
            _status = 'No pose detected';
          } else {
            _status = '${poses.length} pose(s) - ${poses.first.landmarks.length} landmarks';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          // Show readable error message
          final errorMsg = e.toString();
          if (errorMsg.length > 80) {
            _status = errorMsg.substring(0, 80);
          } else {
            _status = errorMsg;
          }
        });
      }
    } finally {
      _isDetecting = false;
    }
  }

  @override
  void dispose() {
    // Clean up resources
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    _poseDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628), // Dark navy background
      body: SafeArea(
        child: Column(
          children: [
            // Header with status
            _buildHeader(context),

            // Camera preview with pose overlay
            Expanded(
              child: _isInitialized && _cameraController != null
                  ? _buildCameraPreview(screenSize, isPortrait)
                  : _buildLoadingOrError(),
            ),

            // Footer with instructions
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// Header widget with status and back button
  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final titleFontSize = isSmallScreen ? 16.0 : 20.0;
    final statusFontSize = isSmallScreen ? 12.0 : 14.0;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF1A2B45), // Lighter navy for header
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
            iconSize: isSmallScreen ? 20 : 24,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pose Detection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _isInitialized
                            ? const Color(0xFFCAFF33)
                            : Colors.red, // Lime green when ready
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        _status,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: statusFontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Camera preview with pose overlay
  Widget _buildCameraPreview(Size screenSize, bool isPortrait) {
    final aspectRatio = isPortrait
        ? _cameraController!.value.aspectRatio
        : 1 / _cameraController!.value.aspectRatio;

    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Camera preview
            CameraPreview(_cameraController!),

            // Pose overlay
            if (_poses.isNotEmpty)
              CustomPaint(
                painter: PosePainter(
                  poses: _poses,
                  imageSize: _imageSize,
                  widgetSize: _calculateWidgetSize(screenSize, isPortrait),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Calculate widget size based on screen size and orientation
  Size _calculateWidgetSize(Size screenSize, bool isPortrait) {
    if (_cameraController == null) return Size.zero;

    final aspectRatio = isPortrait
        ? _cameraController!.value.aspectRatio
        : 1 / _cameraController!.value.aspectRatio;

    double width, height;

    if (isPortrait) {
      width = screenSize.width;
      height = width / aspectRatio;
      if (height > screenSize.height) {
        height = screenSize.height;
        width = height * aspectRatio;
      }
    } else {
      height = screenSize.height;
      width = height * aspectRatio;
      if (width > screenSize.width) {
        width = screenSize.width;
        height = width / aspectRatio;
      }
    }

    return Size(width, height);
  }

  /// Loading or error state widget
  Widget _buildLoadingOrError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_status == 'Initializing...')
            const CircularProgressIndicator(
              color: Color(0xFFCAFF33), // Lime green
            )
          else
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
          const SizedBox(height: 20),
          Text(
            _status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Footer widget with instructions
  Widget _buildFooter(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final fontSize = isSmallScreen ? 11.0 : 13.0;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: const BoxDecoration(
        color: Color(0xFF1A2B45), // Lighter navy for footer
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.accessibility_new,
            color: const Color(0xFFCAFF33), // Lime green
            size: isSmallScreen ? 18 : 20,
          ),
          SizedBox(width: screenWidth * 0.02),
          Flexible(
            child: Text(
              'Stand in front of camera for pose detection',
              style: TextStyle(
                color: Colors.white70,
                fontSize: fontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
