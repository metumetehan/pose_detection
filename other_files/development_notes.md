# Real-Time Pose Detection App - Development Notes

## Project Overview
This is a Flutter app that uses Google ML Kit to detect human poses in real-time from the camera feed and draws the skeletal structure (joints and connections) on the screen.

---

## Step-by-Step Development Process

### 1. Dependencies Added (pubspec.yaml)
- **google_mlkit_pose_detection**: ^0.14.0 - For ML-based pose detection
- **camera**: ^0.11.0+2 - For accessing device camera
- **permission_handler**: ^11.3.1 - For handling camera permissions

### 2. Android Configuration
**File**: `android/app/src/main/AndroidManifest.xml`

Added permissions:
- `CAMERA` - Required to access the device camera
- `INTERNET` - For ML Kit model downloads if needed
- Camera hardware features declared for autofocus

### 3. Project Structure
```
lib/
├── main.dart                       # App entry point with theme and routing
├── screens/
│   ├── home_screen.dart           # Landing page with sport-themed design
│   └── pose_detection_screen.dart # Camera screen with pose detection
├── utils/
│   └── camera_utils.dart          # Helper for converting CameraImage to InputImage
└── painters/
    └── pose_painter.dart          # CustomPainter for drawing pose landmarks
```

---

## Detailed File Explanations

### File 1: lib/main.dart
**Purpose**: App entry point with theme configuration

**Key Components**:
1. **main() function**
   - Initializes Flutter bindings
   - Sets device orientations (portrait and landscape)
   - Configures system UI (status bar, navigation bar)

2. **PoseDetectionApp widget**
   - Root MaterialApp widget
   - Configures dark theme with deep purple and orange colors
   - Sets up app-wide styling
   - Sets HomeScreen as initial route

**State Management**: None (StatelessWidget)

---

### File 2: lib/screens/home_screen.dart
**Purpose**: Landing page with sport-themed design and animations

**Key Components**:
1. **State Variables**:
   - `_animationController`: Controls fade and slide animations
   - `_fadeAnimation`: Opacity animation (0 to 1)
   - `_slideAnimation`: Vertical slide animation

2. **Main Widgets**:
   - Gradient background (deep purple to orange)
   - Animated logo with shadow effects
   - Title and subtitle text
   - Feature cards (3 cards explaining app features)
   - Start button with gradient and shadow

3. **Responsive Design**:
   - Uses MediaQuery to get screen size
   - Adjusts font sizes, paddings, and icon sizes for small screens (<360px)
   - Calculates dynamic spacing based on screen height/width percentages

4. **Navigation**:
   - `_navigateToPoseDetection()`: Pushes to PoseDetectionScreen

**State Management**: setState for animation controller

---

### File 3: lib/screens/pose_detection_screen.dart
**Purpose**: Main screen for real-time pose detection

**Key Components**:

1. **State Variables**:
   - `_cameraController`: Controls camera preview and image stream
   - `_poseDetector`: ML Kit pose detector instance
   - `_isDetecting`: Boolean flag to prevent concurrent detections
   - `_poses`: List of detected Pose objects
   - `_imageSize`: Size of camera image for scaling
   - `_isInitialized`: Camera initialization status
   - `_status`: Status message shown to user

2. **Lifecycle Methods**:
   - `initState()`: Calls _initializeCamera()
   - `dispose()`: Cleans up camera and detector resources

3. **Key Functions**:

   a. **_initializeCamera()**:
      - Requests camera permission using permission_handler
      - Gets available cameras
      - Initializes CameraController with medium resolution and YUV420 format
      - Creates PoseDetector with stream mode
      - Starts image stream

   b. **_processCameraImage(CameraImage image)**:
      - Skips if already processing (isBusy pattern)
      - Converts CameraImage to InputImage using CameraUtils
      - Processes image through PoseDetector
      - Updates state with detected poses
      - Catches and handles errors
      - Sets _isDetecting to false in finally block

   c. **_buildCameraPreview()**:
      - Creates Stack with CameraPreview and pose overlay
      - Uses AspectRatio to maintain camera aspect ratio
      - Overlays CustomPaint with PosePainter when poses detected

   d. **_calculateWidgetSize()**:
      - Calculates proper widget size based on screen size and orientation
      - Handles both portrait and landscape modes
      - Ensures preview doesn't exceed screen bounds

4. **UI Components**:
   - Header: Status indicator, back button, title
   - Camera preview with pose overlay
   - Footer: Instructions for user

5. **Responsive Design**:
   - Adjusts font sizes for small screens
   - Calculates padding based on screen width percentages
   - Handles portrait and landscape orientations

**State Management**: setState for camera, poses, and status updates

---

### File 4: lib/utils/camera_utils.dart
**Purpose**: Utility class for camera image processing

**Key Functions**:

1. **convertCameraImage()**:
   - Takes CameraImage, CameraDescription, and sensor orientation
   - Determines image rotation based on sensor orientation
   - Converts image format from raw to InputImageFormat
   - Extracts plane data (YUV has 3 planes: Y, U, V)
   - Creates InputImagePlaneMetadata for each plane
   - Combines all bytes from all planes
   - Returns InputImage for ML Kit processing

2. **rotationIntToImageRotation()**:
   - Converts integer degrees (0, 90, 180, 270) to InputImageRotation enum
   - Handles all 4 orientations

3. **getSensorOrientation()**:
   - Returns camera sensor orientation from CameraDescription

**Why This is Needed**:
ML Kit requires InputImage format, but camera gives CameraImage. This class bridges the gap and handles rotation/format conversion.

---

### File 5: lib/painters/pose_painter.dart
**Purpose**: CustomPainter for drawing pose skeleton on canvas

**Key Components**:

1. **Constructor Parameters**:
   - `poses`: List of detected poses
   - `imageSize`: Original camera image size
   - `widgetSize`: Size of widget on screen

2. **paint() Method**:
   - Creates Paint objects for joints and connections
   - Different colors for high confidence (yellow) vs low confidence (red)
   - Draws connections first (so they appear behind joints)
   - Draws joints as circles

3. **_drawConnections() Method**:
   - Defines all skeletal connections:
     - Face: ears, eyes, nose
     - Arms: shoulder → elbow → wrist → fingers
     - Body: shoulders and hips connections
     - Legs: hip → knee → ankle → foot
   - Helper function drawLine() connects two landmarks

4. **_scalePoint() Method**:
   - Converts ML Kit coordinates (based on image size) to screen coordinates
   - Calculates scaleX and scaleY ratios
   - Returns scaled Offset

5. **shouldRepaint() Method**:
   - Returns true if poses, imageSize, or widgetSize changed
   - Optimizes repainting

**How It Works**:
ML Kit returns coordinates in image space (e.g., 640x480). This painter scales them to screen space (e.g., 1080x1920) and draws circles for joints and lines for connections.

---

## Key Technical Concepts

### 1. Camera Image Processing Pipeline
```
CameraImage (YUV420)
  → CameraUtils.convertCameraImage()
  → InputImage
  → PoseDetector.processImage()
  → List<Pose>
```

### 2. Coordinate Scaling
```
ML Kit coordinates (image space)
  → PosePainter._scalePoint()
  → Screen coordinates (widget space)
```

### 3. isBusy Pattern
Prevents processing new frames while current frame is being analyzed:
```dart
if (_isDetecting) return;
_isDetecting = true;
try {
  // process image
} finally {
  _isDetecting = false;
}
```

This prevents UI freezing and maintains ~30 FPS.

### 4. Responsive Design Strategy
- Use MediaQuery.of(context).size for screen dimensions
- Define thresholds (e.g., isSmallScreen = width < 360)
- Calculate sizes as percentages of screen size
- Adjust font sizes, paddings, and icon sizes accordingly

### 5. Resource Management
- Always dispose CameraController in dispose()
- Always close PoseDetector in dispose()
- Stop image stream before disposing camera

---

## State Management Approach

**Using setState() throughout the app**:
- HomeScreen: For animations only
- PoseDetectionScreen: For camera state, poses, and status
- No advanced state management (Provider, Bloc, Riverpod, etc.)

**Why setState is sufficient**:
- Local state only (no shared state between screens)
- Simple state updates (camera initialization, pose detection)
- No complex state logic or dependencies

---

## Performance Optimizations

1. **Medium Resolution**: Uses ResolutionPreset.medium (not high) for faster processing
2. **isBusy Pattern**: Skips frames when already processing
3. **Stream Mode**: PoseDetector uses stream mode for better performance
4. **Efficient Repainting**: shouldRepaint only returns true when data changes
5. **No Unnecessary Rebuilds**: Minimal use of setState

---

## Sport Theme Design Elements

1. **Color Scheme**:
   - Deep purple and orange gradient (energetic sports colors)
   - Yellow accents for pose landmarks (high visibility)
   - Green for skeletal connections

2. **Icons**:
   - accessibility_new: Main app icon (human pose)
   - sports_gymnastics: Fitness feature
   - settings_accessibility: Tracking feature

3. **Animations**:
   - Fade-in and slide-up on home screen
   - Smooth transitions between screens

4. **Typography**:
   - Bold titles with letter spacing
   - Clear, readable body text
   - Proper hierarchy

---

## Testing Checklist

- [ ] Camera permission request works
- [ ] Camera preview displays correctly
- [ ] Pose detection runs in real-time
- [ ] Skeletal overlay draws correctly
- [ ] Works on small screens (< 360px width)
- [ ] Works on medium screens (360-600px)
- [ ] Works on large screens (> 600px)
- [ ] Portrait orientation works
- [ ] Landscape orientation works
- [ ] Back button navigates correctly
- [ ] Resources dispose properly when screen closes
- [ ] No memory leaks
- [ ] Smooth 30 FPS performance

---

## Potential Future Enhancements

1. Add pose classification (e.g., detect specific yoga poses)
2. Record pose sessions and save data
3. Compare current pose with reference pose
4. Add exercise counter (squats, push-ups, etc.)
5. Multi-person pose detection
6. Add settings screen for camera resolution
7. Save pose snapshots
8. Share results to social media
