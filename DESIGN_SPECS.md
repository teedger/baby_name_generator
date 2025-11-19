# Design Specifications - Liquid Glass Theme

This document provides detailed visual and technical specifications for the liquid glass design system.

---

## Visual Mockups

### Main Screen - Girl Mode (Light Pink Theme)

```
╔═══════════════════════════════════════╗
║                                       ║
║         ┌─────────────────┐           ║
║         │  Boy    👧Girl  │ Pink      ║  ← Gender Toggle (Active: Girl)
║         └─────────────────┘           ║     Glassmorphic pill shape
║                                       ║
║                                       ║
║                                       ║
║     ╭─────────────────────────╮       ║
║     │  ░░░░░░░░░░░░░░░░░░░░░  │       ║  ← Name Display Card
║     │  ░                   ░  │       ║     Frosted glass effect
║     │  ░   Altansarnai    ░  │       ║     with gradient background
║     │  ░                   ░  │       ║
║     │  ░   Golden Rose     ░  │       ║     Name: Large, bold
║     │  ░                   ░  │       ║     Meaning: Smaller, elegant
║     │  ░░░░░░░░░░░░░░░░░░░░░  │       ║
║     ╰─────────────────────────╯       ║
║                                       ║
║                                       ║
║                                       ║
║              ╭───────╮                ║
║              │   ⟳   │                ║  ← Generate Button
║              │       │                ║     Large circular
║              ╰───────╯                ║     Glassmorphic style
║                                       ║     Ripple on press
║                                       ║
║                                       ║
║                                       ║
║                                       ║
╚═══════════════════════════════════════╝

Background: Soft pink gradient (#FFE5F0 → #FFF0F8)
Floating elements: Subtle animated circles/bubbles
```

### Main Screen - Boy Mode (Light Blue Theme)

```
╔═══════════════════════════════════════╗
║                                       ║
║         ┌─────────────────┐           ║
║         │  👦Boy    Girl  │ Blue      ║  ← Gender Toggle (Active: Boy)
║         └─────────────────┘           ║
║                                       ║
║                                       ║
║                                       ║
║     ╭─────────────────────────╮       ║
║     │  ░░░░░░░░░░░░░░░░░░░░░  │       ║  ← Name Display Card
║     │  ░                   ░  │       ║
║     │  ░     Baatar       ░  │       ║
║     │  ░                   ░  │       ║
║     │  ░      Hero         ░  │       ║
║     │  ░                   ░  │       ║
║     │  ░░░░░░░░░░░░░░░░░░░░░  │       ║
║     ╰─────────────────────────╯       ║
║                                       ║
║                                       ║
║                                       ║
║              ╭───────╮                ║
║              │   ⟳   │                ║
║              │       │                ║
║              ╰───────╯                ║
║                                       ║
║                                       ║
║                                       ║
║                                       ║
╚═══════════════════════════════════════╝

Background: Soft blue gradient (#E5F0FF → #F0F8FF)
```

---

## Component Specifications

### 1. Gender Toggle Component

#### Dimensions
- **Width**: 200pt
- **Height**: 50pt
- **Corner Radius**: 25pt (pill shape)

#### Layout
```
┌──────────────────────────────────┐
│                                  │
│  👦 Boy          👧 Girl         │
│  [Active]         [Inactive]     │
│                                  │
└──────────────────────────────────┘
```

#### States

**Boy Selected:**
- Left half: Blue background (#D6E8FF) with glassmorphic overlay
- Right half: Transparent/subtle
- Animation: Sliding indicator (0.4s spring animation)

**Girl Selected:**
- Right half: Pink background (#FFD6E8) with glassmorphic overlay
- Left half: Transparent/subtle
- Animation: Sliding indicator (0.4s spring animation)

#### SwiftUI Code Example
```swift
struct GenderToggle: View {
    @Binding var selectedGender: Gender

    var body: some View {
        HStack(spacing: 0) {
            GenderOption(
                gender: .boy,
                icon: "👦",
                isSelected: selectedGender == .boy
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    selectedGender = .boy
                }
            }

            GenderOption(
                gender: .girl,
                icon: "👧",
                isSelected: selectedGender == .girl
            )
            .onTapGesture {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    selectedGender = .girl
                }
            }
        }
        .frame(width: 200, height: 50)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
```

---

### 2. Name Display Card

#### Dimensions
- **Width**: 320pt (or 85% screen width)
- **Height**: 200pt
- **Corner Radius**: 30pt
- **Padding**: 24pt all sides

#### Visual Hierarchy
```
┌────────────────────────────────┐
│                                │
│         Altansarnai            │  ← 32pt, Bold, Primary Color
│                                │
│         Golden Rose             │  ← 18pt, Regular, Secondary
│                                │
└────────────────────────────────┘
```

#### Glassmorphic Effect Layers
1. **Base Layer**: Semi-transparent white background (opacity: 0.3)
2. **Blur Layer**: Ultra-thin material blur
3. **Border**: 1pt white with 50% opacity
4. **Shadow**: Soft drop shadow (radius: 20, y-offset: 10)
5. **Inner Gradient**: Subtle radial gradient for depth

#### Typography
- **Name**: SF Pro Display, 32pt, Bold, Weight: 700
- **Meaning**: SF Pro Text, 18pt, Regular, Weight: 400
- **Text Color**: Dark gray (#2C3E50) for readability
- **Letter Spacing**: -0.5pt for name (tight)

#### SwiftUI Code Example
```swift
struct NameDisplayCard: View {
    let name: BabyName
    let themeColor: Color

    var body: some View {
        VStack(spacing: 12) {
            Text(name.name)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: "#2C3E50"))
                .tracking(-0.5)

            Text(name.meaning)
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(Color(hex: "#2C3E50").opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(width: 320, height: 200)
        .padding(24)
        .background(
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: [
                        themeColor.opacity(0.3),
                        themeColor.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Glass blur
                .background(.ultraThinMaterial)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
    }
}
```

---

### 3. Generate Button

#### Dimensions
- **Diameter**: 120pt
- **Icon Size**: 40pt
- **Shadow Radius**: 15pt

#### Visual Details
```
        ╭─────────╮
       ╱           ╲
      │             │
      │      ⟳      │  ← Refresh icon (SF Symbol: arrow.clockwise)
      │             │
       ╲           ╱
        ╰─────────╯
```

#### Interaction States

**Idle State:**
- Scale: 1.0
- Shadow opacity: 0.15
- Icon rotation: 0°

**Pressed State:**
- Scale: 0.95
- Shadow opacity: 0.05
- Icon rotation: 15° (slight pre-rotation)
- Haptic: Medium impact

**Generating State:**
- Scale: 1.0
- Icon rotation: 360° (continuous spin)
- Duration: 0.6s

#### Animation Sequence
1. User taps button → Scale to 0.95 + haptic
2. Icon rotates 360° + name fades out
3. New name fades in with spring animation
4. Button returns to scale 1.0

#### SwiftUI Code Example
```swift
struct GenerateButton: View {
    let action: () -> Void
    let themeColor: Color

    @State private var isPressed = false
    @State private var rotation: Double = 0

    var body: some View {
        Button(action: {
            // Haptic feedback
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            // Animation
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }

            withAnimation(.easeInOut(duration: 0.6)) {
                rotation += 360
            }

            action()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    isPressed = false
                }
            }
        }) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                themeColor.opacity(0.8),
                                themeColor.opacity(0.5)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    )
                    .shadow(
                        color: themeColor.opacity(isPressed ? 0.2 : 0.4),
                        radius: 15,
                        x: 0,
                        y: isPressed ? 5 : 10
                    )

                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(rotation))
            }
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
    }
}
```

---

## Animation Specifications

### Transition Animations

#### Name Change Animation
```swift
// Fade out old name
.transition(.asymmetric(
    insertion: .scale(scale: 0.8).combined(with: .opacity),
    removal: .scale(scale: 1.2).combined(with: .opacity)
))
.animation(.spring(response: 0.6, dampingFraction: 0.7), value: currentName)
```

**Timeline:**
- 0.0s: Old name starts fading out + scaling up (1.0 → 1.2)
- 0.3s: Old name fully transparent and removed
- 0.3s: New name appears, scaled down (0.8) and transparent
- 0.6s: New name reaches full scale (1.0) and full opacity

#### Color Theme Transition
```swift
// Smooth gradient transition
.animation(.easeInOut(duration: 0.8), value: selectedGender)
```

**Timeline:**
- 0.0s: Current theme color at 100%
- 0.4s: Blend of both colors (50/50)
- 0.8s: New theme color at 100%

#### Button Ripple Effect
```swift
struct RippleEffect: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .stroke(Color.white.opacity(0.5), lineWidth: 3)
            .scaleEffect(isAnimating ? 1.5 : 1.0)
            .opacity(isAnimating ? 0 : 1)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    isAnimating = true
                }
            }
    }
}
```

---

## Background Design

### Gradient Specifications

#### Girl Mode (Pink)
```swift
LinearGradient(
    stops: [
        .init(color: Color(hex: "#FFE5F0"), location: 0.0),
        .init(color: Color(hex: "#FFF0F8"), location: 0.5),
        .init(color: Color(hex: "#FFFFFF"), location: 1.0)
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

#### Boy Mode (Blue)
```swift
LinearGradient(
    stops: [
        .init(color: Color(hex: "#E5F0FF"), location: 0.0),
        .init(color: Color(hex: "#F0F8FF"), location: 0.5),
        .init(color: Color(hex: "#FFFFFF"), location: 1.0)
    ],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

### Floating Elements (Optional Enhancement)

Add subtle animated circles that float in the background:

```swift
struct FloatingBubbles: View {
    let color: Color

    var body: some View {
        ZStack {
            ForEach(0..<5) { index in
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: CGFloat.random(in: 50...150))
                    .offset(
                        x: CGFloat.random(in: -100...100),
                        y: CGFloat.random(in: -200...200)
                    )
                    .blur(radius: 20)
            }
        }
        .ignoresSafeArea()
    }
}
```

---

## Accessibility

### Dynamic Type Support
- All text should scale with user's text size preferences
- Minimum target size: 44x44pt for interactive elements
- Support for SF Symbols that scale automatically

### Color Contrast
- **Text on Light Pink**: #2C3E50 (AAA rating)
- **Text on Light Blue**: #2C3E50 (AAA rating)
- **White on Pink Button**: AA rating minimum

### VoiceOver Labels
```swift
Button(action: generateName) {
    // Button content
}
.accessibilityLabel("Generate random Mongolian name")
.accessibilityHint("Tap to see a new name")

Toggle(selectedGender == .girl) {
    // Toggle content
}
.accessibilityLabel("Gender selection")
.accessibilityValue(selectedGender == .girl ? "Girl" : "Boy")
```

---

## Color Palette (Complete)

### Primary Colors
```swift
extension Color {
    // Girl Theme
    static let babyGirl = Color(hex: "#FFD6E8")
    static let babyGirlLight = Color(hex: "#FFE5F0")
    static let babyGirlDark = Color(hex: "#FFC0D9")

    // Boy Theme
    static let babyBoy = Color(hex: "#D6E8FF")
    static let babyBoyLight = Color(hex: "#E5F0FF")
    static let babyBoyDark = Color(hex: "#C0D9FF")

    // Neutrals
    static let textPrimary = Color(hex: "#2C3E50")
    static let textSecondary = Color(hex: "#7F8C8D")
    static let glassWhite = Color.white.opacity(0.8)
    static let glassBorder = Color.white.opacity(0.5)

    // Shadows
    static let shadowLight = Color.black.opacity(0.05)
    static let shadowMedium = Color.black.opacity(0.10)
    static let shadowStrong = Color.black.opacity(0.15)
}
```

### Helper Extension
```swift
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
```

---

## Performance Considerations

### Optimization Tips
1. **Blur Layers**: Limit to 2-3 layers max to avoid performance issues
2. **Animations**: Use `.animation()` modifier sparingly; prefer explicit `withAnimation`
3. **Shadows**: Use `compositingGroup()` before applying shadows for better performance
4. **Images**: Use SF Symbols instead of custom images when possible
5. **Gradients**: Cache gradient definitions rather than recreating them

### Memory Management
- Lazy load name data from JSON on app launch
- Cache previously shown names in-memory (not on disk for v1.0)
- Use `@State` for ephemeral UI state
- Use `@StateObject` for ViewModel lifecycle management

---

## Design Inspiration References

### Liquid Glass Aesthetic
- **Frosted Glass UI**: iOS Control Center, iOS Widgets
- **Glassmorphism**: Modern web design trend (2020+)
- **Material Design**: Subtle depth through shadows and layering
- **Neuomorphism**: Soft shadows and highlights (used sparingly)

### Baby App Design Patterns
- **Soft Pastels**: Gentle on the eyes, non-stimulating
- **Generous Spacing**: Easy tap targets for tired parents
- **Minimal Text**: Quick information at a glance
- **Joyful Interactions**: Delightful animations that spark joy

---

This design system creates a cohesive, modern, and delightful experience that celebrates the special moment of choosing a baby's name.
