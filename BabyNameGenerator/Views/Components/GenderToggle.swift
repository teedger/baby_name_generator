//
//  GenderToggle.swift
//  BabyNameGenerator
//
//  Gender selection toggle component with pill-shaped design
//

import SwiftUI

struct GenderToggle: View {
    @Binding var selectedGender: Gender
    let onToggle: (Gender) -> Void

    var body: some View {
        HStack(spacing: 0) {
            // Boy Option
            GenderOption(
                gender: .boy,
                label: "Boy",
                isSelected: selectedGender == .boy
            )
            .onTapGesture {
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                onToggle(.boy)
            }

            // Girl Option
            GenderOption(
                gender: .girl,
                label: "Girl",
                isSelected: selectedGender == .girl
            )
            .onTapGesture {
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                onToggle(.girl)
            }
        }
        .frame(width: 200, height: 50)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: Color.shadowMedium, radius: 10, x: 0, y: 5)
    }
}

// MARK: - Gender Option Component

struct GenderOption: View {
    let gender: Gender
    let label: String
    let isSelected: Bool

    var body: some View {
        ZStack {
            // Selected background
            if isSelected {
                Capsule()
                    .fill(gender.themeColor.opacity(0.6))
                    .padding(4)
            }

            // Label
            HStack(spacing: 6) {
                Image(systemName: gender == .boy ? "figure.stand" : "figure.stand.dress")
                    .font(.system(size: 16, weight: .medium))

                Text(label)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
            }
            .foregroundColor(isSelected ? .textPrimary : .textSecondary)
        }
        .frame(maxWidth: .infinity)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
    }
}

// MARK: - Preview

struct GenderToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            GenderToggle(selectedGender: .constant(.girl)) { _ in }
            GenderToggle(selectedGender: .constant(.boy)) { _ in }
        }
        .padding()
        .background(Color.babyGirlGradientStart)
    }
}
