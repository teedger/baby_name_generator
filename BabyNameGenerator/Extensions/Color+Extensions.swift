//
//  Color+Extensions.swift
//  BabyNameGenerator
//
//  Color palette extensions for the liquid glass theme
//

import SwiftUI

extension Color {
    // MARK: - Girl Theme (Light Pink)

    /// Main pink color for girl theme
    static let babyGirl = Color(hex: "#FFD6E8")

    /// Accent pink (slightly darker)
    static let babyGirlAccent = Color(hex: "#FFC0D9")

    /// Light pink for gradient start
    static let babyGirlGradientStart = Color(hex: "#FFE5F0")

    /// Very light pink for gradient end
    static let babyGirlGradientEnd = Color(hex: "#FFF0F8")

    // MARK: - Boy Theme (Light Blue)

    /// Main blue color for boy theme
    static let babyBoy = Color(hex: "#D6E8FF")

    /// Accent blue (slightly darker)
    static let babyBoyAccent = Color(hex: "#C0D9FF")

    /// Light blue for gradient start
    static let babyBoyGradientStart = Color(hex: "#E5F0FF")

    /// Very light blue for gradient end
    static let babyBoyGradientEnd = Color(hex: "#F0F8FF")

    // MARK: - Neutral Colors

    /// Primary text color (dark gray)
    static let textPrimary = Color(hex: "#2C3E50")

    /// Secondary text color (medium gray)
    static let textSecondary = Color(hex: "#7F8C8D")

    /// Glass white overlay
    static let glassWhite = Color.white.opacity(0.8)

    /// Glass border color
    static let glassBorder = Color.white.opacity(0.5)

    // MARK: - Shadow Colors

    /// Light shadow
    static let shadowLight = Color.black.opacity(0.05)

    /// Medium shadow
    static let shadowMedium = Color.black.opacity(0.10)

    /// Strong shadow
    static let shadowStrong = Color.black.opacity(0.15)

    // MARK: - Hex Initializer

    /// Initialize color from hex string
    /// - Parameter hex: Hex color string (e.g., "#FF0000" or "FF0000")
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
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
