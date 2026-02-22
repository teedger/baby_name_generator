//
//  ContentView.swift
//  BabyNameGenerator
//
//  Root view of the application with auth, onboarding, and tab navigation
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var settingsManager = SettingsManager.shared
    @ObservedObject var authManager = AuthManager.shared

    var body: some View {
        Group {
            if !authManager.isSignedIn {
                SignInView()
            } else if !settingsManager.hasSeenOnboarding {
                OnboardingView()
            } else {
                MainTabView()
            }
        }
        .preferredColorScheme(settingsManager.colorScheme)
        .animation(.easeInOut, value: authManager.isSignedIn)
        .animation(.easeInOut, value: settingsManager.hasSeenOnboarding)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
