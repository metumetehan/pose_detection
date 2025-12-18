# Quick Test Checklist

## After Installing New APK

### 1. Camera Aspect Ratio Test ✅
- [ ] Open app
- [ ] Tap "Start Detection"
- [ ] Grant camera permission
- [ ] **Check**: Camera preview is NOT stretched
- [ ] **Check**: Objects look natural (not wide or tall)

**Expected**: Camera maintains natural aspect ratio

---

### 2. Pose Detection Test (CRITICAL) ✅
- [ ] Stand 1-3 meters from camera
- [ ] Face the camera directly
- [ ] Ensure good lighting (not too dark)
- [ ] Make sure full body is visible

**Expected**:
- [ ] Status shows: `"1 pose(s) - 33 landmarks"`
- [ ] **Lime green circles** appear on your joints:
  - Face (nose, eyes, ears)
  - Shoulders
  - Elbows
  - Wrists
  - Hips
  - Knees
  - Ankles
  - Feet
- [ ] **Lime green lines** connecting joints
- [ ] Skeleton moves when you move

**If not working**:
- Check status message
- Try better lighting
- Move closer/farther (1-3m)
- Make sure body is fully visible

---

### 3. Performance Test ✅
- [ ] Move your arms
- [ ] Move your legs
- [ ] Walk in place
- [ ] **Check**: Skeleton updates smoothly (no lag)

**Expected**: Smooth 30 FPS updates, no stuttering

---

### 4. Resource Cleanup Test ✅
- [ ] Press back button
- [ ] Returns to home screen
- [ ] Open your phone's default Camera app
- [ ] **Check**: Camera app works normally

**Expected**: Camera is released, other apps can use it

---

### 5. Orientation Test
- [ ] Start pose detection in portrait
- [ ] Rotate phone to landscape
- [ ] **Check**: Camera rotates correctly
- [ ] **Check**: Pose overlay still aligns

---

## Troubleshooting

### Status: "Image conversion failed"
- **Cause**: Image format not recognized
- **Solution**: Contact developer (this shouldn't happen)

### Status: "No pose detected"
- **Cause**: Can't see your body
- **Solutions**:
  - Improve lighting
  - Stand 1-3 meters away
  - Face camera directly
  - Show full body

### Status: "Detection error: ..."
- **Cause**: ML Kit error
- **Solution**: Check error message details

### Skeleton doesn't align with body
- **Cause**: Coordinate scaling issue
- **Solution**: Contact developer

### App crashes
- **Cause**: Various possible issues
- **Solution**: Check error logs

---

## What Success Looks Like

✅ Camera preview looks natural (not stretched)
✅ Lime green skeleton appears on your body
✅ 33 landmarks detected and shown
✅ Skeleton moves smoothly with your body
✅ Status shows "1 pose(s) - 33 landmarks"
✅ Back button stops camera properly
✅ Other apps can use camera after

---

## Quick Report Format

After testing, report:

1. **Camera Aspect**: ✅ / ❌
2. **Pose Detection**: ✅ / ❌
3. **Landmark Count**: [number shown in status]
4. **Performance**: Smooth / Laggy
5. **Resource Cleanup**: ✅ / ❌
6. **Any Errors**: [status message if error]

Example:
```
1. Camera Aspect: ✅
2. Pose Detection: ✅
3. Landmark Count: 33
4. Performance: Smooth
5. Resource Cleanup: ✅
6. Any Errors: None
```

or

```
1. Camera Aspect: ✅
2. Pose Detection: ❌
3. Landmark Count: 0
4. Performance: N/A
5. Resource Cleanup: ✅
6. Any Errors: "No pose detected"
```

---

Good luck! The app should work perfectly now. 🎯
