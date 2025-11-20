//
//  GenerateButton.swift
//  BabyNameGenerator
//
//  Large circular button for generating random names
//

import SwiftUI

struct GenerateButton: View {
    let action: () -> Void
    let themeColor: Color
    @ObservedObject var settingsManager = SettingsManager.shared
    @State private var isPressed = false
    @State private var rotation: Double = 0

    var body: some View {
        Button(action: handleTap) {
            ZStack {
                // Button background with gradient
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

                // Refresh icon
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(rotation))
            }
        }
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .buttonStyle(PlainButtonStyle())
    }

    private func handleTap() {
        // Haptic feedback (respects settings)
        if settingsManager.enableHaptics {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        }

        // Press animation (respects settings)
        if settingsManager.enableAnimations {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }

            // Rotation animation
            withAnimation(.easeInOut(duration: 0.6)) {
                rotation += 360
            }
        } else {
            isPressed = true
        }

        // Execute action
        action()

        // Reset press state
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if settingsManager.enableAnimations {
                withAnimation {
                    isPressed = false
                }
            } else {
                isPressed = false
            }
        }
    }
}

// MARK: - Preview

struct GenerateButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            GenerateButton(action: {}, themeColor: .babyGirl)
            GenerateButton(action: {}, themeColor: .babyBoy)
        }
        .padding()
        .background(Color.babyGirlGradientStart)
    }
}
