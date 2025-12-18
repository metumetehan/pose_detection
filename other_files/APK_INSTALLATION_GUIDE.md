# APK Installation Guide

## Building the APK

The APK is being built with the command:
```bash
flutter build apk --release
```

Once complete, the APK file will be located at:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## Installing on Your Android Phone

### Method 1: Direct Transfer (Recommended)

1. **Connect your phone to computer via USB cable**
   - Enable "File Transfer" mode on your phone (not just charging)

2. **Copy the APK file**
   - Navigate to: `build/app/outputs/flutter-apk/`
   - Copy `app-release.apk` to your phone's Downloads folder

3. **Install on phone**
   - Open "Files" or "My Files" app on your phone
   - Navigate to Downloads folder
   - Tap on `app-release.apk`
   - If prompted, enable "Install from Unknown Sources" for Files app
   - Tap "Install"
   - Wait for installation to complete
   - Tap "Open" to launch the app

### Method 2: Via Cloud Storage

1. **Upload APK to cloud**
   - Upload `app-release.apk` to Google Drive, Dropbox, or OneDrive

2. **Download on phone**
   - Open cloud storage app on your phone
   - Download the APK file

3. **Install**
   - Tap the downloaded APK
   - Enable "Install from Unknown Sources" if prompted
   - Tap "Install"

### Method 3: Via Email

1. **Email yourself the APK**
   - Attach `app-release.apk` to an email
   - Send to yourself

2. **Open email on phone**
   - Download the attachment
   - Tap to install

---

## Enabling "Install from Unknown Sources"

If you get a security warning:

### Android 8.0 and above:
1. When you tap the APK, you'll see a prompt
2. Tap "Settings"
3. Enable "Allow from this source"
4. Go back and tap the APK again

### Android 7.1 and below:
1. Go to Settings > Security
2. Enable "Unknown Sources"
3. Tap OK on the warning

---

## First Launch

1. **Launch the app**
   - Tap "Open" after installation
   - Or find "Pose Detection" in your app drawer

2. **Grant camera permission**
   - The app will request camera permission
   - Tap "Allow" or "While using the app"

3. **Test the app**
   - Tap "Start Detection" on home screen
   - Stand 1-3 meters from camera
   - Your pose should be detected and drawn in lime green!

---

## Troubleshooting

### Installation blocked
- **Issue**: "Install blocked" or "For your security, your phone is not allowed to install unknown apps from this source"
- **Solution**: Enable "Install from Unknown Sources" for the app you're using to install (Files, Chrome, etc.)

### App won't install
- **Issue**: Installation fails
- **Solution**:
  - Make sure you have enough storage space
  - Try uninstalling any previous version
  - Restart your phone and try again

### Camera permission denied
- **Issue**: App says "Camera permission denied"
- **Solution**:
  - Go to Settings > Apps > Pose Detection > Permissions
  - Enable Camera permission

### Pose not detected
- **Issue**: "No pose detected" message
- **Solution**:
  - Ensure good lighting
  - Stand 1-3 meters from camera
  - Make sure your full body is visible
  - Face the camera directly

---

## APK Details

- **File name**: app-release.apk
- **Size**: ~50-60 MB (includes ML Kit model)
- **Min Android version**: Android 5.0 (API 21)
- **Target Android version**: Latest
- **Permissions required**: Camera only

---

## Testing Checklist

Once installed, test:
- [ ] App launches successfully
- [ ] Home screen displays with DeepSport colors (dark navy + lime green)
- [ ] "Start Detection" button works
- [ ] Camera permission request appears
- [ ] Camera preview shows after granting permission
- [ ] Pose detection works (lime green skeleton)
- [ ] Joints and connections are visible
- [ ] Back button returns to home screen
- [ ] App works in portrait mode
- [ ] App works in landscape mode (optional)

---

## Sharing the APK

If you want to share the APK with others (e.g., for your job interview):

1. **Upload to cloud storage**
   - Upload the APK file
   - Generate a shareable link
   - Set permissions to "Anyone with the link can view"

2. **Include in portfolio**
   - Add download link to your resume/portfolio
   - Or demonstrate live during interview

3. **Alternative: Use Android App Bundle**
   - For Google Play Store submission (if needed later)
   - Build with: `flutter build appbundle --release`

---

## File Location Reminder

After build completes, find your APK at:
```
D:\flutter_projects\deepsport_case\pose_detection\build\app\outputs\flutter-apk\app-release.apk
```

---

Good luck testing! The app should work perfectly on your Android device.
