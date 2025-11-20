//
//  SettingsManager.swift
//  BabyNameGenerator
//
//  Manager for app settings and preferences
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()

    // MARK: - Published Settings

    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }

    @Published var enableHaptics: Bool {
        didSet {
            UserDefaults.standard.set(enableHaptics, forKey: "enableHaptics")
        }
    }

    @Published var enableAnimations: Bool {
        didSet {
            UserDefaults.standard.set(enableAnimations, forKey: "enableAnimations")
        }
    }

    @Published var hasSeenOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: "hasSeenOnboarding")
        }
    }

    @Published var defaultGender: Gender {
        didSet {
            UserDefaults.standard.set(defaultGender.rawValue, forKey: "defaultGender")
        }
    }

    // MARK: - Initialization

    private init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        self.enableHaptics = UserDefaults.standard.object(forKey: "enableHaptics") as? Bool ?? true
        self.enableAnimations = UserDefaults.standard.object(forKey: "enableAnimations") as? Bool ?? true
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

        let genderString = UserDefaults.standard.string(forKey: "defaultGender") ?? "girl"
        self.defaultGender = Gender(rawValue: genderString) ?? .girl
    }

    // MARK: - Color Scheme

    var colorScheme: ColorScheme? {
        isDarkMode ? .dark : .light
    }

    // MARK: - Reset

    func resetToDefaults() {
        isDarkMode = false
        enableHaptics = true
        enableAnimations = true
        defaultGender = .girl
    }
}
