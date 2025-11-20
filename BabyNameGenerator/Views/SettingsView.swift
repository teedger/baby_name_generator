//
//  SettingsView.swift
//  BabyNameGenerator
//
//  App settings and preferences screen
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsManager = SettingsManager.shared
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @ObservedObject var historyManager = HistoryManager.shared
    @State private var showingClearAlert = false
    @State private var showingResetAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LiquidGlassBackground(colors: settingsManager.defaultGender.gradientColors)

                ScrollView {
                    VStack(spacing: 24) {
                        // Appearance section
                        appearanceSection

                        // Preferences section
                        preferencesSection

                        // Data section
                        dataSection

                        // About section
                        aboutSection

                        Spacer(minLength: 50)
                    }
                    .padding()
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .alert("Clear All Data", isPresented: $showingClearAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesManager.clearAll()
                historyManager.clearHistory()
            }
        } message: {
            Text("This will remove all favorites and history. This action cannot be undone.")
        }
        .alert("Reset Settings", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                settingsManager.resetToDefaults()
            }
        } message: {
            Text("This will reset all settings to their default values.")
        }
    }

    // MARK: - Appearance Section

    private var appearanceSection: some View {
        SettingsSection(title: "Appearance") {
            // Dark mode toggle
            SettingsToggleRow(
                icon: "moon.fill",
                iconColor: .purple,
                title: "Dark Mode",
                isOn: $settingsManager.isDarkMode
            )

            // Enable animations
            SettingsToggleRow(
                icon: "sparkles",
                iconColor: .yellow,
                title: "Animations",
                isOn: $settingsManager.enableAnimations
            )
        }
    }

    // MARK: - Preferences Section

    private var preferencesSection: some View {
        SettingsSection(title: "Preferences") {
            // Enable haptics
            SettingsToggleRow(
                icon: "hand.tap.fill",
                iconColor: .blue,
                title: "Haptic Feedback",
                isOn: $settingsManager.enableHaptics
            )

            // Default gender
            HStack {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.pink)
                    .frame(width: 28)

                Text("Default Gender")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textPrimary)

                Spacer()

                Picker("", selection: $settingsManager.defaultGender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.displayName).tag(gender)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()
            .background(Color.white.opacity(0.3))
            .cornerRadius(12)
        }
    }

    // MARK: - Data Section

    private var dataSection: some View {
        SettingsSection(title: "Data") {
            // Stats
            HStack {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.green)
                    .frame(width: 28)

                Text("Favorites")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textPrimary)

                Spacer()

                Text("\(favoritesManager.favorites.count)")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            .padding()
            .background(Color.white.opacity(0.3))
            .cornerRadius(12)

            HStack {
                Image(systemName: "clock.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.orange)
                    .frame(width: 28)

                Text("History")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textPrimary)

                Spacer()

                Text("\(historyManager.history.count)")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            .padding()
            .background(Color.white.opacity(0.3))
            .cornerRadius(12)

            // Clear data button
            Button(action: { showingClearAlert = true }) {
                HStack {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .frame(width: 28)

                    Text("Clear All Data")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.red)

                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.3))
                .cornerRadius(12)
            }

            // Reset settings button
            Button(action: { showingResetAlert = true }) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 16))
                        .foregroundColor(.orange)
                        .frame(width: 28)

                    Text("Reset Settings")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.orange)

                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.3))
                .cornerRadius(12)
            }
        }
    }

    // MARK: - About Section

    private var aboutSection: some View {
        SettingsSection(title: "About") {
            // Version
            HStack {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
                    .frame(width: 28)

                Text("Version")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textPrimary)

                Spacer()

                Text("1.1.0")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            .padding()
            .background(Color.white.opacity(0.3))
            .cornerRadius(12)

            // Total names
            HStack {
                Image(systemName: "text.book.closed.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.purple)
                    .frame(width: 28)

                Text("Total Names")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textPrimary)

                Spacer()

                Text("110")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.textSecondary)
            }
            .padding()
            .background(Color.white.opacity(0.3))
            .cornerRadius(12)

            // Made with love
            HStack {
                Spacer()
                Text("Made with ❤️ for parents")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.textSecondary)
                Spacer()
            }
            .padding(.top, 8)
        }
    }
}

// MARK: - Settings Section

struct SettingsSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.textSecondary)
                .textCase(.uppercase)
                .padding(.leading, 4)

            VStack(spacing: 8) {
                content
            }
        }
    }
}

// MARK: - Settings Toggle Row

struct SettingsToggleRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(iconColor)
                .frame(width: 28)

            Text(title)
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.textPrimary)

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(12)
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
