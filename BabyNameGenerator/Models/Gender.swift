//
//  Gender.swift
//  BabyNameGenerator
//
//  Model representing baby gender with associated theme colors
//

import SwiftUI

enum Gender: String, Codable, CaseIterable {
    case boy
    case girl

    /// Theme color for the gender
    var themeColor: Color {
        switch self {
        case .boy:
            return .babyBoy
        case .girl:
            return .babyGirl
        }
    }

    /// Accent color for the gender (slightly darker)
    var accentColor: Color {
        switch self {
        case .boy:
            return .babyBoyAccent
        case .girl:
            return .babyGirlAccent
        }
    }

    /// Gradient colors for background
    var gradientColors: [Color] {
        switch self {
        case .boy:
            return [.babyBoyGradientStart, .babyBoyGradientEnd, .white]
        case .girl:
            return [.babyGirlGradientStart, .babyGirlGradientEnd, .white]
        }
    }

    /// Display name for the gender
    var displayName: String {
        rawValue.capitalized
    }

    /// Icon for the gender (using SF Symbols)
    var icon: String {
        switch self {
        case .boy:
            return "figure.child"
        case .girl:
            return "figure.child"
        }
    }
}
