//
//  NameGeneratorView.swift
//  BabyNameGenerator
//
//  Main view for the baby name generator app
//

import SwiftUI

struct NameGeneratorView: View {
    @StateObject private var viewModel = NameGeneratorViewModel()

    var body: some View {
        ZStack {
            // Animated gradient background
            LiquidGlassBackground(colors: viewModel.selectedGender.gradientColors)
                .animation(.easeInOut(duration: 0.8), value: viewModel.selectedGender)

            // Main content
            VStack(spacing: 40) {
                Spacer()
                    .frame(height: 60)

                // Gender toggle
                GenderToggle(
                    selectedGender: $viewModel.selectedGender,
                    onToggle: { gender in
                        viewModel.toggleGender(to: gender)
                    }
                )

                Spacer()
                    .frame(height: 20)

                // Name display card
                NameDisplay(
                    name: viewModel.currentName,
                    themeColor: viewModel.selectedGender.themeColor
                )
                .id(viewModel.currentName?.id) // Force view refresh on name change
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: viewModel.currentName)

                Spacer()

                // Generate button
                GenerateButton(
                    action: {
                        viewModel.generateRandomName()
                    },
                    themeColor: viewModel.selectedGender.themeColor
                )

                Spacer()
                    .frame(height: 80)

                // Optional: Name count indicator
                Text("\(viewModel.getNameCount()) \(viewModel.selectedGender.displayName) Names")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary.opacity(0.6))
                    .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

// MARK: - Preview

struct NameGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NameGeneratorView()
    }
}
