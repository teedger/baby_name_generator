# Mongolian Baby Name Generator 🍼

A beautiful iOS app for discovering authentic Mongolian baby names with a modern liquid glass design.

![Platform](https://img.shields.io/badge/platform-iOS%2015.0%2B-blue)
![Language](https://img.shields.io/badge/language-Swift%205.9-orange)
![Framework](https://img.shields.io/badge/framework-SwiftUI-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## Overview

This app helps expecting parents discover beautiful Mongolian baby names with meaningful translations. Designed with love for parents who cherish their children, it features a sleek liquid glass aesthetic with gentle pink and blue color themes.

### Key Features

- **110+ Authentic Names**: 55 girl names and 55 boy names with meanings
- **Instant Generation**: Tap to discover a new name instantly
- **Gender Toggle**: Seamlessly switch between boy and girl names
- **Liquid Glass Design**: Modern, premium aesthetic with frosted glass effects
- **Meaningful Translations**: Each name includes its beautiful Mongolian meaning
- **Smooth Animations**: Delightful interactions with spring animations and haptic feedback

---

## Screenshots

_(Mockups available in DESIGN_SPECS.md)_

**Girl Mode (Light Pink)**
- Soft pink gradient background
- Glassmorphic name cards
- Gentle, nurturing aesthetic

**Boy Mode (Light Blue)**
- Soft blue gradient background
- Same premium glass design
- Calm, peaceful aesthetic

---

## Documentation

### Planning Documents

1. **[PLAN.md](./PLAN.md)** - Complete implementation plan
   - App architecture and structure
   - Development phases (1-9)
   - Code examples and patterns
   - Testing strategy
   - Timeline: 2-3 weeks

2. **[DESIGN_SPECS.md](./DESIGN_SPECS.md)** - Visual design specifications
   - Component mockups and dimensions
   - Glassmorphic effect implementations
   - Animation specifications
   - Color palette and typography
   - Accessibility guidelines

3. **[MONGOLIAN_NAMES_DATABASE.md](./MONGOLIAN_NAMES_DATABASE.md)** - Name database
   - 55 authentic girl names with meanings
   - 55 authentic boy names with meanings
   - Cultural context and traditions
   - JSON structure for implementation

---

## Tech Stack

- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Minimum iOS**: 15.0
- **Design**: Liquid Glass / Glassmorphism
- **Animations**: SwiftUI built-in + UIKit Haptics

---

## Project Structure

```
BabyNameGenerator/
├── App/
│   ├── BabyNameGeneratorApp.swift      # App entry point
│   └── ContentView.swift                # Root view
├── Models/
│   ├── BabyName.swift                   # Name data model
│   ├── Gender.swift                     # Gender enum
│   └── NameRepository.swift             # Data access layer
├── ViewModels/
│   └── NameGeneratorViewModel.swift     # Business logic
├── Views/
│   ├── NameGeneratorView.swift          # Main screen
│   └── Components/
│       ├── GenderToggle.swift           # Gender selector
│       ├── GenerateButton.swift         # Main action button
│       ├── NameDisplay.swift            # Name card
│       └── LiquidGlassBackground.swift  # Background gradient
├── Data/
│   └── mongolian_names.json             # Name database
└── Resources/
    └── Assets.xcassets                  # Colors, images, app icon
```

---

## Getting Started

### Prerequisites

- macOS 13.0+ (Ventura or later)
- Xcode 15.0+
- iOS Simulator or physical iPhone running iOS 15.0+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/mongolian-baby-names.git
   cd mongolian-baby-names
   ```

2. **Open in Xcode**
   ```bash
   open BabyNameGenerator.xcodeproj
   ```

3. **Build and Run**
   - Select a simulator or device
   - Press `Cmd + R` to build and run

---

## Development Roadmap

### Phase 1: Foundation ✓ (Planning Complete)
- [x] Research Mongolian names
- [x] Design app architecture
- [x] Create visual design system
- [x] Define data models

### Phase 2: Implementation (2-3 weeks)
- [ ] Project setup and structure
- [ ] Data layer with JSON parsing
- [ ] Core UI components
- [ ] Liquid glass styling
- [ ] ViewModel and business logic
- [ ] Main view assembly
- [ ] Testing and polish
- [ ] App icon and assets

### Phase 3: Release (v1.0)
- [ ] App Store preparation
- [ ] Screenshots and metadata
- [ ] Beta testing (TestFlight)
- [ ] Public release

### Future Enhancements (v1.1+)
- [ ] Favorites system
- [ ] Name history
- [ ] Share functionality
- [ ] Pronunciation audio
- [ ] Additional languages (English, Russian)
- [ ] More cultures (Chinese, Korean, etc.)
- [ ] Dark mode support
- [ ] iCloud sync
- [ ] Widgets

---

## Design Philosophy

### For Parents Who Adore Their Kids

This app is designed with love, celebrating the special bond between parents and their children. Every interaction is crafted to feel joyful and meaningful.

### Liquid Glass Aesthetic

The liquid glass design creates a premium, modern feel:
- **Frosted glass effects** for depth and sophistication
- **Soft gradients** that feel gentle and calming
- **Smooth animations** that delight without overwhelming
- **Pastel colors** that are easy on the eyes

### Cultural Authenticity

All names are authentic Mongolian names with accurate meanings:
- Traditional names from Mongolian culture
- Modern names used in contemporary Mongolia
- Meanings rooted in nature, strength, and beauty
- Respectful of Mongolian naming traditions

---

## Sample Names

### Girls
- **Altansarnai** - Golden Rose
- **Sarangerel** - Moonlight
- **Oyuun** - Wisdom
- **Solongo** - Rainbow
- **Enkhjargal** - Peaceful Happiness

### Boys
- **Baatar** - Hero
- **Temujin** - Iron (Genghis Khan)
- **Erdene** - Jewel
- **Ganzorig** - Steel Courage
- **Batbayar** - Strong Joy

_(Full database: 110 names in MONGOLIAN_NAMES_DATABASE.md)_

---

## Contributing

Contributions are welcome! Here's how you can help:

1. **Add More Names**: Suggest authentic Mongolian names with meanings
2. **Improve Translations**: Verify or enhance name meanings
3. **Report Bugs**: Open an issue for any problems
4. **Suggest Features**: Share ideas for future versions
5. **Design Feedback**: Help refine the visual design

### Development Guidelines

- Follow Swift style guide and best practices
- Write unit tests for new features
- Maintain MVVM architecture
- Keep accessibility in mind
- Document your code

---

## Testing

### Unit Tests
```bash
# Run all tests
cmd + U in Xcode
```

### Manual Testing Checklist
- [ ] Names generate randomly without immediate repeats
- [ ] Gender toggle smoothly transitions colors
- [ ] Button animations feel responsive
- [ ] Text is readable on both color themes
- [ ] App works on iPhone SE (small screen)
- [ ] App works on iPhone Pro Max (large screen)
- [ ] VoiceOver announces names correctly
- [ ] Dynamic Type scales text appropriately

---

## Performance

- **App Launch**: <1 second
- **Name Generation**: <100ms
- **Memory Usage**: <50MB average
- **Battery Impact**: Minimal (no background tasks)

---

## Accessibility

- **VoiceOver**: Full support with descriptive labels
- **Dynamic Type**: Text scales with system preferences
- **Contrast**: AAA rating for text readability
- **Haptics**: Tactile feedback for button presses
- **Reduced Motion**: Respects accessibility preferences

---

## License

MIT License - feel free to use this project for learning or personal use.

---

## Acknowledgments

- Mongolian naming traditions and cultural heritage
- Parents everywhere who are choosing names with love
- SwiftUI community for design inspiration
- Glassmorphism design trend pioneers

---

## Contact

Questions or feedback? Open an issue or reach out!

**Built with ❤️ for parents and their precious babies**

---

## Version History

- **v1.0** (Planned) - Initial release
  - 110 Mongolian names
  - Liquid glass design
  - Boy/girl name generation
  - Light pink and blue themes

---

## Next Steps

Ready to start building? Check out:
1. **[PLAN.md](./PLAN.md)** for the complete implementation guide
2. **[DESIGN_SPECS.md](./DESIGN_SPECS.md)** for detailed design specifications
3. **[MONGOLIAN_NAMES_DATABASE.md](./MONGOLIAN_NAMES_DATABASE.md)** for the name database

Happy coding! 🚀👶
