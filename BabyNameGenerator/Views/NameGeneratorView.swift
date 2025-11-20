//
//  NameGeneratorView.swift
//  BabyNameGenerator
//
//  Main view for the baby name generator app
//

import SwiftUI

struct NameGeneratorView: View {
    @StateObject private var viewModel = NameGeneratorViewModel()
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @ObservedObject var historyManager = HistoryManager.shared
    @ObservedObject var settingsManager = SettingsManager.shared

    @State private var showingNameDetail = false

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

                // Name display card with favorite button
                VStack(spacing: 16) {
                    NameDisplay(
                        name: viewModel.currentName,
                        themeColor: viewModel.selectedGender.themeColor
                    )
                    .id(viewModel.currentName?.id)
                    .animation(
                        settingsManager.enableAnimations
                            ? .spring(response: 0.6, dampingFraction: 0.7)
                            : .none,
                        value: viewModel.currentName
                    )
                    .onTapGesture {
                        if viewModel.currentName != nil {
                            showingNameDetail = true
                        }
                    }

                    // Favorite button
                    if let name = viewModel.currentName {
                        Button(action: {
                            if settingsManager.enableHaptics {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                            }
                            favoritesManager.toggleFavorite(name)
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: favoritesManager.isFavorite(name) ? "heart.fill" : "heart")
                                    .font(.system(size: 18))
                                Text(favoritesManager.isFavorite(name) ? "Saved" : "Save to Favorites")
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                            }
                            .foregroundColor(favoritesManager.isFavorite(name) ? .red : .textSecondary)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(Color.white.opacity(0.5))
                            )
                        }
                    }
                }

                Spacer()

                // Generate button
                GenerateButton(
                    action: {
                        viewModel.generateRandomName()

                        // Add to history
                        if let name = viewModel.currentName {
                            historyManager.addToHistory(name)
                        }
                    },
                    themeColor: viewModel.selectedGender.themeColor
                )

                Spacer()
                    .frame(height: 80)

                // Name count indicator
                Text("\(viewModel.getNameCount()) \(viewModel.selectedGender.displayName) Names")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary.opacity(0.6))
                    .padding(.bottom, 20)
            }
            .padding()
        }
        .sheet(isPresented: $showingNameDetail) {
            if let name = viewModel.currentName {
                NameDetailView(name: name)
            }
        }
        .onAppear {
            // Set default gender from settings
            if viewModel.currentName == nil {
                viewModel.toggleGender(to: settingsManager.defaultGender)
            }
        }
    }
}

// MARK: - Preview

struct NameGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        NameGeneratorView()
    }
}
