//
//  OnboardingView.swift
//  BabyNameGenerator
//
//  Onboarding tutorial for first-time users
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var settingsManager = SettingsManager.shared
    @State private var currentPage = 0

    let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "heart.fill",
            iconColor: .pink,
            title: "Welcome!",
            description: "Discover beautiful Mongolian names for your precious baby",
            backgroundColor: [Color.babyGirlGradientStart, Color.babyGirlGradientEnd, .white]
        ),
        OnboardingPage(
            icon: "arrow.clockwise",
            iconColor: .blue,
            title: "Generate Names",
            description: "Tap the button to discover new names instantly with their beautiful meanings",
            backgroundColor: [Color.babyBoyGradientStart, Color.babyBoyGradientEnd, .white]
        ),
        OnboardingPage(
            icon: "heart.circle.fill",
            iconColor: .red,
            title: "Save Favorites",
            description: "Tap the heart to save names you love. Access them anytime in the Favorites tab",
            backgroundColor: [Color.babyGirlGradientStart, Color.babyGirlGradientEnd, .white]
        ),
        OnboardingPage(
            icon: "magnifyingglass",
            iconColor: .purple,
            title: "Browse & Search",
            description: "Search through all 110 names, filter by origin, and sort however you like",
            backgroundColor: [Color.babyBoyGradientStart, Color.babyBoyGradientEnd, .white]
        )
    ]

    var body: some View {
        ZStack {
            // Background
            LiquidGlassBackground(colors: pages[currentPage].backgroundColor)
                .animation(.easeInOut(duration: 0.5), value: currentPage)

            VStack {
                // Skip button
                HStack {
                    Spacer()
                    Button("Skip") {
                        completeOnboarding()
                    }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary)
                    .padding()
                }

                Spacer()

                // Page content
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // Page indicators
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.textPrimary : Color.textSecondary.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding()

                // Action button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        completeOnboarding()
                    }
                }) {
                    Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(pages[currentPage].iconColor)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }

    private func completeOnboarding() {
        withAnimation {
            settingsManager.hasSeenOnboarding = true
        }
    }
}

// MARK: - Onboarding Page Model

struct OnboardingPage {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    let backgroundColor: [Color]
}

// MARK: - Onboarding Page View

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 30) {
            // Icon
            ZStack {
                Circle()
                    .fill(page.iconColor.opacity(0.2))
                    .frame(width: 120, height: 120)

                Image(systemName: page.icon)
                    .font(.system(size: 50))
                    .foregroundColor(page.iconColor)
            }

            // Title
            Text(page.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)

            // Description
            Text(page.description)
                .font(.system(size: 18, design: .rounded))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

// MARK: - Preview

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
