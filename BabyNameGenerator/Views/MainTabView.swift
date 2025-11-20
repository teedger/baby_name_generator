//
//  MainTabView.swift
//  BabyNameGenerator
//
//  Tab-based navigation for the app
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var settingsManager = SettingsManager.shared
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Generate tab
            NameGeneratorView()
                .tabItem {
                    Image(systemName: "wand.and.stars")
                    Text("Generate")
                }
                .tag(0)

            // Browse tab
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
                .tag(1)

            // Favorites tab
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
                .tag(2)

            // History tab
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("History")
                }
                .tag(3)

            // Settings tab
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(4)
        }
        .accentColor(settingsManager.defaultGender.themeColor)
    }
}

// MARK: - Preview

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
