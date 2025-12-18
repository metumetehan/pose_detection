# DeepSport Brand Color Scheme Update

## Updated Color Palette

Based on the DeepSport website branding, the app now uses:

### Primary Colors
- **Dark Navy Blue**: `#0A1628` - Main background color
- **Lighter Navy**: `#1A2B45` - Headers, footers, and surface elements
- **Lime Green**: `#CAFF33` - Accent color for buttons, icons, and highlights

### Color Usage

#### 1. Backgrounds
- **App Background**: Dark navy (`#0A1628`)
- **Home Screen Gradient**: Dark navy to lighter navy gradient
- **Camera Screen**: Dark navy background

#### 2. Headers & Footers
- **Header/Footer Background**: Lighter navy (`#1A2B45`)
- **Text**: White for readability

#### 3. Accent Elements
- **Buttons**: Lime green background with dark navy text
- **Icons**: Lime green
- **Status Indicators**: Lime green when active
- **Pose Landmarks**: Lime green circles (joints)
- **Pose Connections**: Lime green lines (skeleton)
- **Feature Card Icons**: Lime green with subtle lime background

#### 4. Interactive Elements
- **Logo**: Lime green circle with dark navy icon
- **Start Button**: Lime green with dark navy text and icon
- **Loading Spinner**: Lime green
- **Active Status Dot**: Lime green

---

## Files Modified

### 1. lib/main.dart
- Updated `scaffoldBackgroundColor` to dark navy
- Changed `primary` color to dark navy
- Changed `secondary` color to lime green
- Updated `surface` color to lighter navy
- Changed button colors to lime green background with dark text

### 2. lib/screens/home_screen.dart
- Updated background gradient to dark navy shades
- Changed logo to solid lime green
- Updated logo icon to dark navy on lime background
- Changed start button to lime green
- Updated button text/icon to dark navy
- Changed feature card icons to lime green

### 3. lib/screens/pose_detection_screen.dart
- Updated scaffold background to dark navy
- Changed header background to lighter navy
- Changed footer background to lighter navy
- Updated status indicator to lime green when ready
- Changed footer icon to lime green
- Updated loading spinner to lime green

### 4. lib/painters/pose_painter.dart
- Changed joint color from yellow to lime green
- Changed connection color from green to lime green
- Maintained red for low-confidence landmarks

---

## Color Comparison

### Before (Original Sport Theme)
- Deep purple to orange gradient
- Yellow accents
- Green connections
- Orange buttons

### After (DeepSport Branding)
- Dark navy to lighter navy gradient
- Lime green accents
- Lime green connections
- Lime green buttons with dark text

---

## Visual Hierarchy

The new color scheme maintains excellent contrast and readability:

1. **High Contrast**: Dark navy background with lime green accents
2. **Readability**: White text on dark backgrounds
3. **Visibility**: Bright lime green for important interactive elements
4. **Brand Consistency**: Matches DeepSport website exactly

---

## Accessibility

- **Contrast Ratio**: Lime green (#CAFF33) on dark navy (#0A1628) exceeds WCAG AA standards
- **Visibility**: High-visibility lime green ensures pose landmarks are clearly visible
- **Consistency**: Colors remain consistent across all screens

---

## Testing Recommendations

When testing the updated color scheme:

1. ✅ Verify lime green buttons are easily visible
2. ✅ Check pose landmarks are clear against camera feed
3. ✅ Ensure text remains readable on all backgrounds
4. ✅ Test in different lighting conditions
5. ✅ Verify brand consistency with DeepSport website

---

This color scheme update perfectly aligns the app with DeepSport's brand identity while maintaining excellent usability and visual appeal!
