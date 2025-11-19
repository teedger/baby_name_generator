//
//  NameDisplay.swift
//  BabyNameGenerator
//
//  Glassmorphic card displaying the baby name and its meaning
//

import SwiftUI

struct NameDisplay: View {
    let name: BabyName?
    let themeColor: Color

    var body: some View {
        VStack(spacing: 12) {
            if let name = name {
                // Name text
                Text(name.name)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.textPrimary)
                    .tracking(-0.5)
                    .multilineTextAlignment(.center)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .scale(scale: 1.2).combined(with: .opacity)
                    ))

                // Meaning text
                Text(name.meaning)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .scale(scale: 1.2).combined(with: .opacity)
                    ))
            } else {
                // Placeholder when no name
                Text("Tap to discover\na beautiful name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
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
        .shadow(color: Color.shadowMedium, radius: 20, x: 0, y: 10)
    }
}

// MARK: - Preview

struct NameDisplay_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            NameDisplay(name: BabyName.sampleGirl, themeColor: .babyGirl)
            NameDisplay(name: BabyName.sampleBoy, themeColor: .babyBoy)
            NameDisplay(name: nil, themeColor: .babyGirl)
        }
        .padding()
        .background(Color.babyGirlGradientStart)
    }
}
