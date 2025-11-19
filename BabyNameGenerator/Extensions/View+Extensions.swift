//
//  View+Extensions.swift
//  BabyNameGenerator
//
//  SwiftUI View extensions for common modifiers
//

import SwiftUI

extension View {
    /// Apply glassmorphic card style
    func glassmorphicCard(cornerRadius: CGFloat = 30) -> some View {
        self.modifier(GlassmorphicCardModifier(cornerRadius: cornerRadius))
    }

    /// Apply a gradient background with colors
    func gradientBackground(_ colors: [Color]) -> some View {
        self.background(
            LinearGradient(
                colors: colors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}
