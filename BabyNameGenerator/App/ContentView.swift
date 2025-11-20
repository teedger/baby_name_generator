//
//  ContentView.swift
//  BabyNameGenerator
//
//  Root view of the application with onboarding and tab navigation
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var settingsManager = SettingsManager.shared

    var body: some View {
        Group {
            if settingsManager.hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
        .preferredColorScheme(settingsManager.colorScheme)
        .animation(.easeInOut, value: settingsManager.hasSeenOnboarding)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
