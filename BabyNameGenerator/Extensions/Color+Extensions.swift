//
//  Color+Extensions.swift
//  BabyNameGenerator
//
//  Color palette extensions for the liquid glass theme
//

import SwiftUI

extension Color {
    // MARK: - Adaptive Theme Colors

    private static var isDark: Bool { SettingsManager.shared.isDarkMode }

    // MARK: - Girl Theme

    static var babyGirl: Color { isDark ? Color(hex: "#8B4060") : Color(hex: "#FFD6E8") }
    static var babyGirlAccent: Color { isDark ? Color(hex: "#A04870") : Color(hex: "#FFC0D9") }
    static var babyGirlGradientStart: Color { isDark ? Color(hex: "#2E1520") : Color(hex: "#FFE5F0") }
    static var babyGirlGradientEnd: Color { isDark ? Color(hex: "#1A0E14") : Color(hex: "#FFF0F8") }

    // MARK: - Boy Theme

    static var babyBoy: Color { isDark ? Color(hex: "#405E8B") : Color(hex: "#D6E8FF") }
    static var babyBoyAccent: Color { isDark ? Color(hex: "#4870A0") : Color(hex: "#C0D9FF") }
    static var babyBoyGradientStart: Color { isDark ? Color(hex: "#152030") : Color(hex: "#E5F0FF") }
    static var babyBoyGradientEnd: Color { isDark ? Color(hex: "#0E141A") : Color(hex: "#F0F8FF") }

    // MARK: - Text Colors

    static var textPrimary: Color { isDark ? Color(hex: "#E0E0E0") : Color(hex: "#2C3E50") }
    static var textSecondary: Color { isDark ? Color(hex: "#A0A0A0") : Color(hex: "#7F8C8D") }

    // MARK: - Glass Colors

    static var glassWhite: Color { isDark ? Color.white.opacity(0.1) : Color.white.opacity(0.8) }
    static var glassBorder: Color { isDark ? Color.white.opacity(0.15) : Color.white.opacity(0.5) }
    static var glassBackground: Color { isDark ? Color.white.opacity(0.08) : Color.white.opacity(0.5) }
    static var glassCard: Color { isDark ? Color.white.opacity(0.06) : Color.white.opacity(0.3) }

    // MARK: - Shadow Colors

    static var shadowLight: Color { Color.black.opacity(isDark ? 0.3 : 0.05) }
    static var shadowMedium: Color { Color.black.opacity(isDark ? 0.4 : 0.10) }
    static var shadowStrong: Color { Color.black.opacity(isDark ? 0.5 : 0.15) }

    // MARK: - Hex Initializer

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
