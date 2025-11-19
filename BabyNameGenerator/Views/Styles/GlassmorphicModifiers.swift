//
//  GlassmorphicModifiers.swift
//  BabyNameGenerator
//
//  View modifiers for liquid glass / glassmorphic effects
//

import SwiftUI

/// Glassmorphic card style with frosted glass effect
struct GlassmorphicCardModifier: ViewModifier {
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.glassWhite)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.glassBorder, lineWidth: 1)
            )
            .shadow(color: Color.shadowMedium, radius: 20, x: 0, y: 10)
    }
}

/// Glassmorphic button style with colored background
struct GlassmorphicButtonModifier: ViewModifier {
    let color: Color
    let isPressed: Bool

    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [
                        color.opacity(0.8),
                        color.opacity(0.5)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .background(.ultraThinMaterial)
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
            )
            .shadow(
                color: color.opacity(isPressed ? 0.2 : 0.4),
                radius: 15,
                x: 0,
                y: isPressed ? 5 : 10
            )
    }
}

/// Animated gradient background
struct AnimatedGradientBackground: View {
    let colors: [Color]
    @State private var animateGradient = false

    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: animateGradient ? .topLeading : .bottomLeading,
            endPoint: animateGradient ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}
