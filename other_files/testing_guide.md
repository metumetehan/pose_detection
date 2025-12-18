# Testing Guide for Pose Detection App

## Prerequisites

### Required Hardware
- **Android device with camera** (physical device required)
- USB cable to connect device to computer
- OR Android emulator with camera support (not recommended for ML Kit)

### Why Android Device is Required
- Camera access is needed for pose detection
- Windows/Web/Chrome cannot access device camera in the same way
- ML Kit performs better on actual Android hardware
- Real-time processing requires device GPU

---

## How to Run on Android Device

### Step 1: Enable Developer Mode on Android
1. Go to **Settings** > **About Phone**
2. Tap **Build Number** 7 times
3. Developer mode will be enabled

### Step 2: Enable USB Debugging
1. Go to **Settings** > **Developer Options**
2. Enable **USB Debugging**
3. Connect device via USB cable
4. Accept debugging prompt on phone

### Step 3: Verify Device Connection
```bash
flutter devices
```

You should see your Android device listed.

### Step 4: Run the App
```bash
flutter run -d <device-id>
```

Replace `<device-id>` with your device ID from the previous command.

Or simply:
```bash
flutter run
```
Then select your Android device from the list.

---

## Testing Checklist

### Home Screen Tests
- [ ] App launches successfully
- [ ] Gradient background displays correctly
- [ ] Logo animation plays on load
- [ ] Title and subtitle are visible
- [ ] All 3 feature cards display
- [ ] Start button is visible and clickable
- [ ] Colors match sport theme (purple/orange)

### Navigation Tests
- [ ] Tapping "Start Detection" navigates to camera screen
- [ ] Back button returns to home screen
- [ ] No crashes during navigation

### Camera Screen Tests
- [ ] Camera permission dialog appears
- [ ] Granting permission starts camera
- [ ] Camera preview shows full screen
- [ ] Status indicator shows "Ready" when initialized
- [ ] Status shows "No pose detected" when no person visible

### Pose Detection Tests
- [ ] Standing in front of camera shows pose
- [ ] Yellow circles appear on body joints
- [ ] Green lines connect joints (skeleton)
- [ ] Pose updates in real-time (smooth 30 FPS)
- [ ] Moving body parts updates overlay immediately
- [ ] Multiple poses can be detected
- [ ] Low confidence landmarks show in red

### Responsive Design Tests

#### Small Screen (< 360px width)
- [ ] Text sizes are readable
- [ ] Buttons are tappable
- [ ] No text overflow
- [ ] All content fits on screen

#### Medium Screen (360-600px)
- [ ] Layout looks balanced
- [ ] Spacing is appropriate
- [ ] Icons are properly sized

#### Large Screen (> 600px / Tablets)
- [ ] Content doesn't look stretched
- [ ] Proportions are maintained
- [ ] Camera preview scales correctly

### Orientation Tests
- [ ] Portrait mode works correctly
- [ ] Landscape mode works correctly
- [ ] Camera preview aspect ratio is maintained
- [ ] Pose overlay aligns with camera preview
- [ ] UI elements reposition appropriately

### Performance Tests
- [ ] App runs smoothly without lag
- [ ] No frame drops during pose detection
- [ ] App doesn't overheat device
- [ ] Battery drain is reasonable
- [ ] Memory usage is stable

### Error Handling Tests
- [ ] Denying camera permission shows error message
- [ ] Error message is clear and helpful
- [ ] No camera available shows appropriate message
- [ ] Detection errors are handled gracefully

### Resource Management Tests
- [ ] Closing camera screen stops camera
- [ ] No camera still running in background
- [ ] App can be reopened without issues
- [ ] Memory is properly released

---

## Expected Behavior

### When Standing in Front of Camera
You should see:
- **Yellow circles** on these joints:
  - Nose, eyes, ears
  - Shoulders, elbows, wrists
  - Hips, knees, ankles
  - Fingers and toes

- **Green lines** connecting:
  - Face landmarks
  - Arms (shoulder to elbow to wrist)
  - Body (shoulders to hips)
  - Legs (hip to knee to ankle)

### Performance Expectations
- **FPS**: 25-30 frames per second
- **Latency**: Minimal delay (< 100ms)
- **Accuracy**: Depends on lighting and pose visibility

---

## Troubleshooting

### Camera Permission Issues
**Problem**: Permission denied
**Solution**: Go to Settings > Apps > Pose Detection > Permissions > Enable Camera

### Camera Not Starting
**Problem**: Camera preview stays black
**Solution**:
- Restart app
- Check if another app is using camera
- Reboot device

### No Pose Detected
**Problem**: Status shows "No pose detected"
**Solution**:
- Ensure good lighting
- Stand within 1-3 meters from camera
- Face the camera
- Ensure full body is visible

### Low FPS / Laggy
**Problem**: Pose updates slowly
**Solution**:
- Close other apps
- Device may be low-spec
- Reduce camera resolution (already set to medium)

### Overlay Misaligned
**Problem**: Pose skeleton doesn't match body
**Solution**:
- This should not happen if code is correct
- Check device orientation
- Restart app

---

## Test on Different Devices

Try testing on:
1. **Small phone** (< 5.5 inches) - e.g., older Samsung, Xiaomi
2. **Medium phone** (5.5-6.5 inches) - e.g., most modern phones
3. **Large phone/phablet** (> 6.5 inches) - e.g., Samsung Note, iPhone Pro Max
4. **Tablet** (7-10 inches) - e.g., Samsung Tab, iPad with Android

---

## Screenshots to Take

For job application portfolio:
1. Home screen
2. Feature cards closeup
3. Camera screen with pose detected
4. Multiple poses (if possible)
5. Different orientations
6. Different screen sizes

---

## Known Limitations

1. **Windows/Web**: Cannot run camera functionality
2. **iOS**: Not configured (Android-only for now)
3. **Emulator**: ML Kit may not work properly
4. **Low light**: Pose detection accuracy decreases
5. **Partial occlusion**: May lose some landmarks

---

## Next Steps After Testing

If all tests pass:
1. Take screenshots for portfolio
2. Record video demo
3. Document any issues found
4. Optimize if performance issues
5. Prepare explanation for interview

---

Good luck with your job application! 🚀
