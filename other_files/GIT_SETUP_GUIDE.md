# Git Setup Guide

## What's Ignored

The `.gitignore` file has been configured to exclude:

### Build Outputs
- `*.apk` - APK files (81+ MB each)
- `*.aab` - App bundles
- `/build/` - Build directory
- `/android/app/debug`, `/android/app/profile`, `/android/app/release`

### IDE Files
- `.vscode/` - VS Code settings
- `.idea/` - Android Studio/IntelliJ settings
- `*.iml`, `*.ipr`, `*.iws` - IntelliJ files

### Generated Files
- `.dart_tool/` - Dart tooling
- `.flutter-plugins` - Flutter plugin list
- `.packages` - Package dependencies
- `*.g.dart` - Generated code

### Platform Specific
- `/android/.gradle/` - Gradle cache
- `/android/local.properties` - Local Android config
- `/ios/Pods/` - iOS dependencies
- OS files (`.DS_Store`, `Thumbs.db`)

### What's INCLUDED (Not Ignored)

✅ **other_files/** - All documentation is tracked!
  - development_notes.md
  - widget_by_widget_explanation.md
  - app_summary.md
  - testing_guide.md
  - APK_INSTALLATION_GUIDE.md
  - CRITICAL_FIXES.md
  - etc.

✅ **Source code** - All `.dart` files in `/lib`
✅ **Configuration** - `pubspec.yaml`, `AndroidManifest.xml`
✅ **README.md** - Project overview

---

## Initial Git Setup

If you haven't committed yet:

```bash
# Check status
git status

# Add all files (respecting .gitignore)
git add .

# Create initial commit
git commit -m "Initial commit: Real-Time Pose Detection app with DeepSport branding"

# Push to GitHub
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

---

## Typical Git Workflow

### After Making Changes

```bash
# Check what changed
git status

# Add specific files
git add lib/screens/pose_detection_screen.dart
git add lib/utils/camera_utils.dart

# Or add all changes
git add .

# Commit with meaningful message
git commit -m "Fix: Corrected pose detection image conversion for ML Kit"

# Push to GitHub
git push
```

---

## Recommended Commit Messages

### Bug Fixes
```
Fix: Corrected camera aspect ratio stretching
Fix: Resolved pose detection landmark visibility issue
Fix: Fixed resource disposal on screen exit
```

### Features
```
Add: Implemented DeepSport brand color scheme
Add: Created pose detection with ML Kit integration
Add: Added responsive design for all screen sizes
```

### Documentation
```
Docs: Updated development notes with technical details
Docs: Added widget-by-widget explanation guide
Docs: Created APK installation instructions
```

### Refactoring
```
Refactor: Simplified camera image conversion logic
Refactor: Improved error handling in pose detection
```

---

## Repository Structure (What Gets Committed)

```
pose_detection/
├── .gitignore              ✅ Committed
├── README.md               ✅ Committed
├── pubspec.yaml            ✅ Committed
├── lib/                    ✅ All source code committed
│   ├── main.dart
│   ├── screens/
│   ├── painters/
│   └── utils/
├── android/                ✅ Configuration only (not builds)
│   ├── app/
│   │   └── src/main/AndroidManifest.xml
│   └── build.gradle.kts
├── ios/                    ✅ Configuration only
├── other_files/            ✅ ALL documentation committed
│   ├── development_notes.md
│   ├── widget_by_widget_explanation.md
│   ├── app_summary.md
│   ├── testing_guide.md
│   ├── APK_INSTALLATION_GUIDE.md
│   ├── CRITICAL_FIXES.md
│   ├── QUICK_TEST_CHECKLIST.md
│   ├── FIX_NDK_ERROR.md
│   ├── color_scheme_update.md
│   └── PROJECT_COMPLETE.md
└── build/                  ❌ NOT committed (ignored)
    └── app/
        └── outputs/
            └── flutter-apk/
                └── app-release.apk  ❌ Ignored (81+ MB)
```

---

## Sharing APK

Since APK files are ignored (too large for Git):

### Option 1: GitHub Releases
```bash
# Build APK
flutter build apk --release

# Go to GitHub → Releases → Create new release
# Upload app-release.apk as a release asset
```

### Option 2: Cloud Storage
```bash
# Upload to Google Drive/Dropbox/OneDrive
# Share link in README or repository description
```

### Option 3: Include Link in README
Add to README.md:
```markdown
## Download APK
[Download Latest APK](https://drive.google.com/your-link-here)
```

---

## Checking Repository Size

```bash
# See what's taking up space
git count-objects -vH

# See largest files in repository
git ls-files | xargs ls -lh | sort -k5 -hr | head -20
```

Your repository should be:
- **Source code**: ~100-200 KB
- **Documentation**: ~50-100 KB
- **Configuration**: ~20-50 KB
- **Total**: Under 1 MB ✅

If larger, check if build outputs leaked in!

---

## Common Git Commands

### View Changes
```bash
git status              # See what changed
git diff                # See specific changes
git log --oneline       # See commit history
```

### Undo Changes
```bash
git checkout -- file.dart   # Discard changes to file
git reset HEAD file.dart    # Unstage file
git reset --soft HEAD^      # Undo last commit (keep changes)
```

### Branching
```bash
git branch feature-name     # Create branch
git checkout feature-name   # Switch to branch
git checkout -b feature-name # Create and switch
git merge feature-name      # Merge branch into current
```

---

## For Job Application

### Repository Description
```
Real-Time Pose Detection app using Flutter & Google ML Kit.
Detects human poses in real-time from camera feed with
30 FPS performance. Built for DeepSport job application.
```

### Topics/Tags to Add on GitHub
- `flutter`
- `dart`
- `machine-learning`
- `ml-kit`
- `pose-detection`
- `computer-vision`
- `android`
- `real-time`
- `deepsport`

### Make Repository Public
Settings → Danger Zone → Change visibility → Public

---

## Best Practices

✅ **DO**:
- Commit frequently with meaningful messages
- Keep commits focused (one feature/fix per commit)
- Document major changes in commit messages
- Update README when adding features

❌ **DON'T**:
- Commit build outputs (already ignored)
- Commit API keys or secrets
- Make huge commits with many unrelated changes
- Use vague commit messages like "fixed stuff"

---

Your repository is now properly configured for GitHub! 🚀
