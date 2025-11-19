# Quick Start Guide 🚀

Get your Mongolian Baby Name Generator app running in 5 minutes!

---

## Prerequisites

- macOS 13.0+ (Ventura or later)
- Xcode 15.0+
- iPhone Simulator or physical iPhone (iOS 15.0+)

---

## Step 1: Create Xcode Project

1. Open Xcode
2. Click **File → New → Project**
3. Select **iOS** → **App**
4. Configure project:
   - **Product Name**: `BabyNameGenerator`
   - **Organization Identifier**: `com.yourname` (use your own)
   - **Interface**: **SwiftUI**
   - **Language**: **Swift**
   - **Use Core Data**: Unchecked
   - **Include Tests**: Optional
5. Click **Next** and save in a location of your choice

---

## Step 2: Add Source Files

### Option A: Drag and Drop (Easiest)

1. In Finder, open the `BabyNameGenerator/` folder from this repository
2. Select all folders: `App`, `Models`, `ViewModels`, `Views`, `Extensions`, `Data`
3. Drag them into the Xcode project navigator (left sidebar)
4. In the dialog:
   - ✅ **Copy items if needed**
   - ✅ **Create groups**
   - ✅ Make sure **BabyNameGenerator** target is selected
5. Click **Finish**

### Option B: Manual Copy

1. Delete the default `ContentView.swift` in Xcode (if exists in root)
2. Right-click on project in navigator → **Add Files to "BabyNameGenerator"**
3. Navigate to each folder and add files:
   - `App/BabyNameGeneratorApp.swift`
   - `App/ContentView.swift`
   - `Models/*.swift` (all 3 files)
   - `ViewModels/NameGeneratorViewModel.swift`
   - `Views/NameGeneratorView.swift`
   - `Views/Components/*.swift` (all 4 files)
   - `Views/Styles/GlassmorphicModifiers.swift`
   - `Extensions/*.swift` (both files)
   - `Data/mongolian_names.json` ⚠️ **IMPORTANT!**

---

## Step 3: Verify JSON File

**CRITICAL**: Make sure `mongolian_names.json` is added to the app bundle!

1. Click on `mongolian_names.json` in Xcode
2. In **File Inspector** (right sidebar):
   - Check **Target Membership**
   - ✅ **BabyNameGenerator** should be checked

If not checked, the app will crash!

---

## Step 4: Update App Entry Point (if needed)

If Xcode created a default `@main` file:

1. Find the file with `@main` attribute (usually `BabyNameGeneratorApp.swift`)
2. Make sure it matches our implementation:

```swift
import SwiftUI

@main
struct BabyNameGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

---

## Step 5: Configure Deployment Target

1. Click on project name in navigator (top item)
2. Select **BabyNameGenerator** target
3. Go to **General** tab
4. Under **Deployment Info**:
   - **iOS Deployment Target**: 15.0 or higher
   - **iPhone Orientation**: Portrait only (uncheck Landscape)

---

## Step 6: Build and Run! 🎉

1. Select a simulator from the top bar:
   - Recommended: **iPhone 14** or **iPhone 15**
2. Press **Cmd + R** or click the **Play** button
3. Wait for build to complete
4. The app should launch in the simulator!

---

## Expected Behavior

### When App Launches:
✅ Light pink gradient background
✅ "Boy/Girl" toggle at top (Girl selected by default)
✅ Glass card showing a Mongolian girl name
✅ Large circular button in the middle
✅ "55 Girl Names" text at bottom

### When You Tap the Button:
✅ Button scales down and rotates
✅ Haptic feedback (if on device)
✅ New name appears with smooth animation
✅ Previous name fades out

### When You Switch to Boy:
✅ Background transitions to light blue
✅ New boy name appears
✅ "55 Boy Names" text updates
✅ Smooth color transition

---

## Troubleshooting

### ❌ "Cannot find 'mongolian_names' in scope"
**Solution**: Make sure `mongolian_names.json` is added to the target
- Select the JSON file
- Check **Target Membership** in File Inspector
- Rebuild (Cmd + B)

### ❌ "Names not loading"
**Solution**: Check console for errors
- Look for: `❌ Error: Could not find mongolian_names.json`
- Make sure JSON file has `.json` extension
- Verify JSON is valid (use a JSON validator)

### ❌ Build errors about missing imports
**Solution**: Check deployment target
- Go to project settings
- Set iOS Deployment Target to 15.0+
- Clean build folder (Cmd + Shift + K)
- Rebuild

### ❌ App crashes on launch
**Solution**: Check @main attribute
- Only ONE file should have `@main`
- Make sure it's `BabyNameGeneratorApp.swift`
- Delete any duplicate app entry points

### ❌ Colors not showing correctly
**Solution**: Verify all extensions are included
- Make sure `Color+Extensions.swift` is in the project
- Check for any missing imports
- Rebuild

---

## Testing the App

Run through this checklist:

- [ ] App launches without crashes
- [ ] Default shows a girl name
- [ ] Tap button generates new name
- [ ] Switch to Boy shows boy names
- [ ] Switch back to Girl shows girl names
- [ ] Button animates on tap
- [ ] Colors transition smoothly
- [ ] No duplicate names in quick succession
- [ ] Text is readable
- [ ] Layout looks good on different screen sizes

---

## Next Steps

### Customize the App:
- Edit colors in `Color+Extensions.swift`
- Add more names to `mongolian_names.json`
- Modify animations in component files
- Change fonts or sizes

### Prepare for Release:
1. Design app icon (1024x1024)
2. Create launch screen
3. Test on real device
4. Submit to App Store

### Add Features:
- Favorites system
- Name history
- Share functionality
- Dark mode
- More languages

See [PLAN.md](PLAN.md) for full feature roadmap!

---

## File Checklist

Make sure all these files are in your Xcode project:

### App (2 files)
- [ ] BabyNameGeneratorApp.swift
- [ ] ContentView.swift

### Models (3 files)
- [ ] BabyName.swift
- [ ] Gender.swift
- [ ] NameRepository.swift

### ViewModels (1 file)
- [ ] NameGeneratorViewModel.swift

### Views (1 file + 2 subfolders)
- [ ] NameGeneratorView.swift
- [ ] Components/GenderToggle.swift
- [ ] Components/GenerateButton.swift
- [ ] Components/NameDisplay.swift
- [ ] Components/LiquidGlassBackground.swift
- [ ] Styles/GlassmorphicModifiers.swift

### Extensions (2 files)
- [ ] Color+Extensions.swift
- [ ] View+Extensions.swift

### Data (1 file) - CRITICAL!
- [ ] mongolian_names.json ⚠️

**Total: 16 files**

---

## Support

Having issues? Check these resources:

1. **Implementation Guide**: [IMPLEMENTATION.md](BabyNameGenerator/IMPLEMENTATION.md)
2. **Full Plan**: [PLAN.md](PLAN.md)
3. **Design Specs**: [DESIGN_SPECS.md](DESIGN_SPECS.md)
4. **Project Structure**: [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)

---

## Success! 🎊

If you see the app running with beautiful Mongolian names appearing when you tap the button, **congratulations!** You've successfully set up the Baby Name Generator app.

Now you can:
- Play with the app
- Show it to friends and family
- Customize it to your liking
- Prepare it for App Store submission

**Happy naming!** 👶💕

---

Built with ❤️ for parents who adore their kids
