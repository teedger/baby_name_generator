# Project Structure Overview

This document provides a complete overview of all implemented files and their purposes.

## Directory Tree

```
baby_name_generator/
├── README.md                          # Project overview and documentation
├── PLAN.md                            # Complete implementation plan
├── DESIGN_SPECS.md                    # Visual design specifications
├── MONGOLIAN_NAMES_DATABASE.md        # Name database documentation
├── PROJECT_STRUCTURE.md               # This file
│
└── BabyNameGenerator/                 # Main app source code
    ├── IMPLEMENTATION.md              # Guide for opening in Xcode
    ├── Info.plist.template            # iOS app configuration template
    │
    ├── App/                           # App entry point
    │   ├── BabyNameGeneratorApp.swift # Main app struct (@main)
    │   └── ContentView.swift          # Root view
    │
    ├── Models/                        # Data models
    │   ├── BabyName.swift             # Name data structure
    │   ├── Gender.swift               # Gender enum with themes
    │   └── NameRepository.swift       # Data access layer
    │
    ├── ViewModels/                    # Business logic
    │   └── NameGeneratorViewModel.swift # Main view model
    │
    ├── Views/                         # UI components
    │   ├── NameGeneratorView.swift    # Main screen
    │   │
    │   ├── Components/                # Reusable UI components
    │   │   ├── GenderToggle.swift     # Boy/Girl toggle
    │   │   ├── GenerateButton.swift   # Main action button
    │   │   ├── NameDisplay.swift      # Name card
    │   │   └── LiquidGlassBackground.swift # Animated background
    │   │
    │   └── Styles/                    # Design system
    │       └── GlassmorphicModifiers.swift # Reusable modifiers
    │
    ├── Extensions/                    # Swift extensions
    │   ├── Color+Extensions.swift     # Color palette
    │   └── View+Extensions.swift      # View helpers
    │
    └── Data/                          # App data
        └── mongolian_names.json       # 110 Mongolian names
```

---

## File Descriptions

### Root Documentation

#### README.md
- Project overview and key features
- Quick start guide
- Tech stack information
- Development roadmap
- Sample names showcase

#### PLAN.md
- Complete 9-phase implementation plan
- App architecture (MVVM)
- Code examples and patterns
- Testing strategy
- Timeline: 2-3 weeks

#### DESIGN_SPECS.md
- Visual mockups (ASCII art)
- Component specifications
- Color palette definitions
- Animation specifications
- Accessibility guidelines

#### MONGOLIAN_NAMES_DATABASE.md
- 55 girl names with meanings
- 55 boy names with meanings
- Cultural context
- JSON structure reference

---

### App Entry Point (`App/`)

#### BabyNameGeneratorApp.swift (10 lines)
```swift
@main
struct BabyNameGeneratorApp: App
```
- Main app entry point
- SwiftUI App protocol conformance
- Launches ContentView

#### ContentView.swift (15 lines)
```swift
struct ContentView: View
```
- Root view of the application
- Contains NameGeneratorView
- Forces light mode for v1.0

---

### Data Models (`Models/`)

#### Gender.swift (50 lines)
```swift
enum Gender: String, Codable, CaseIterable
```
- Boy/Girl enum
- Theme colors for each gender
- Gradient configurations
- Display properties (name, icon)

#### BabyName.swift (60 lines)
```swift
struct BabyName: Codable, Identifiable, Equatable
```
- Name data structure
- Properties: id, name, meaning, gender, origin
- Sample data for previews
- Codable for JSON parsing

#### NameRepository.swift (80 lines)
```swift
class NameRepository
```
- Data access layer
- Loads names from JSON file
- Filters by gender
- Random name generation
- Prevents immediate repeats

---

### Business Logic (`ViewModels/`)

#### NameGeneratorViewModel.swift (90 lines)
```swift
class NameGeneratorViewModel: ObservableObject
```
- @Published currentName
- @Published selectedGender
- @Published isAnimating
- generateRandomName() method
- toggleGender() method
- Name history management (last 5 names)

---

### Main View (`Views/`)

#### NameGeneratorView.swift (80 lines)
```swift
struct NameGeneratorView: View
```
- Main app screen
- Integrates all components:
  - LiquidGlassBackground
  - GenderToggle
  - NameDisplay
  - GenerateButton
- Manages layout and spacing
- Handles theme transitions

---

### UI Components (`Views/Components/`)

#### GenderToggle.swift (80 lines)
```swift
struct GenderToggle: View
struct GenderOption: View
```
- Pill-shaped toggle button
- Boy/Girl selection
- Smooth animations
- Haptic feedback
- Theme color transitions

#### GenerateButton.swift (90 lines)
```swift
struct GenerateButton: View
```
- Large circular button (120pt diameter)
- Refresh icon with rotation animation
- Press animation (scale 0.95)
- Haptic feedback (medium impact)
- Glassmorphic styling with gradients

#### NameDisplay.swift (80 lines)
```swift
struct NameDisplay: View
```
- Glassmorphic card (320x200pt)
- Name text (36pt, bold)
- Meaning text (18pt, regular)
- Fade in/out transitions
- Scale animations

#### LiquidGlassBackground.swift (100 lines)
```swift
struct LiquidGlassBackground: View
struct FloatingBubbles: View
```
- Animated gradient background
- Floating glass bubbles (5 circles)
- Slow, organic movements
- Smooth color transitions
- 3-second animation cycles

---

### Design System (`Views/Styles/`)

#### GlassmorphicModifiers.swift (60 lines)
```swift
struct GlassmorphicCardModifier: ViewModifier
struct GlassmorphicButtonModifier: ViewModifier
struct AnimatedGradientBackground: View
```
- Reusable glassmorphic effects
- Ultra-thin material blur
- White borders and overlays
- Soft drop shadows
- Gradient backgrounds

---

### Swift Extensions (`Extensions/`)

#### Color+Extensions.swift (100 lines)
```swift
extension Color
```
- Complete color palette:
  - Girl theme (pink shades)
  - Boy theme (blue shades)
  - Neutral colors (text, glass)
  - Shadow colors
- Hex initializer (supports #RGB, #RRGGBB, #AARRGGBB)

#### View+Extensions.swift (20 lines)
```swift
extension View
```
- .glassmorphicCard() modifier
- .gradientBackground() helper
- Convenience methods

---

### Data (`Data/`)

#### mongolian_names.json (400 lines)
```json
{
  "names": [
    {
      "name": "Altansarnai",
      "meaning": "Golden Rose",
      "gender": "girl",
      "origin": "Traditional"
    },
    ...
  ]
}
```
- 110 total names
- 55 girl names
- 55 boy names
- Authentic Mongolian names
- Meanings in English
- Origin tags (Traditional/Modern/Historical)

---

## File Statistics

| Category | Files | Total Lines | Description |
|----------|-------|-------------|-------------|
| **Models** | 3 | ~190 | Data structures and repository |
| **ViewModels** | 1 | ~90 | Business logic |
| **Views** | 5 | ~430 | UI components and screens |
| **Extensions** | 2 | ~120 | Swift extensions |
| **Data** | 1 | ~400 | JSON database |
| **App** | 2 | ~25 | App entry points |
| **Docs** | 2 | ~200 | Implementation guides |
| **Total** | **16** | **~1,455** | Complete implementation |

---

## Key Features by File

### Core Functionality
- **Random Generation**: NameGeneratorViewModel.swift
- **Gender Filtering**: NameRepository.swift, Gender.swift
- **Data Loading**: NameRepository.swift
- **State Management**: NameGeneratorViewModel.swift

### UI/UX
- **Glassmorphic Design**: GlassmorphicModifiers.swift
- **Animations**: All component files
- **Color Themes**: Color+Extensions.swift, Gender.swift
- **Haptics**: GenerateButton.swift, GenderToggle.swift

### Data
- **Name Database**: mongolian_names.json
- **Models**: BabyName.swift
- **Access Layer**: NameRepository.swift

---

## Architecture Patterns

### MVVM (Model-View-ViewModel)
- **Model**: BabyName, Gender, NameRepository
- **View**: All views in Views/ folder
- **ViewModel**: NameGeneratorViewModel

### SwiftUI
- Declarative UI
- @StateObject for ViewModel
- @Published for reactive properties
- Combine framework for bindings

### Repository Pattern
- NameRepository abstracts data access
- Separates data loading from business logic
- Easy to swap data sources

---

## Dependencies

### Internal
- SwiftUI (iOS 15.0+)
- Foundation
- Combine

### External
- None! Pure Swift/SwiftUI implementation

---

## Next Steps for Xcode

1. Create new Xcode project
2. Copy all files maintaining structure
3. Add mongolian_names.json to bundle
4. Build and run (Cmd + R)
5. Test on simulator or device

See [IMPLEMENTATION.md](BabyNameGenerator/IMPLEMENTATION.md) for detailed setup instructions.

---

**Status**: ✅ **Complete and Ready for Xcode**

All files have been implemented and are ready to be opened in Xcode!
