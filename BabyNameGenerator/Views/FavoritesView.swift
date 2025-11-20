//
//  FavoritesView.swift
//  BabyNameGenerator
//
//  View displaying saved favorite names
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @ObservedObject var settingsManager = SettingsManager.shared
    @State private var selectedGender: Gender = .girl
    @State private var selectedName: BabyName?
    @State private var showingNameDetail = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LiquidGlassBackground(colors: selectedGender.gradientColors)
                    .animation(.easeInOut(duration: 0.8), value: selectedGender)

                VStack(spacing: 20) {
                    // Gender filter
                    GenderToggle(
                        selectedGender: $selectedGender,
                        onToggle: { gender in
                            selectedGender = gender
                        }
                    )
                    .padding(.top, 20)

                    // Favorites list
                    if favoritesManager.getFavorites(for: selectedGender).isEmpty {
                        emptyStateView
                    } else {
                        favoritesListView
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !favoritesManager.favorites.isEmpty {
                        Button("Clear All") {
                            favoritesManager.clearAll()
                        }
                        .foregroundColor(.red)
                    }
                }
            }
        }
        .sheet(isPresented: $showingNameDetail) {
            if let name = selectedName {
                NameDetailView(name: name)
            }
        }
    }

    // MARK: - Subviews

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.textSecondary.opacity(0.5))

            Text("No Favorites Yet")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.textPrimary)

            Text("Tap the heart icon when generating\nnames to save your favorites here")
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
    }

    private var favoritesListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(favoritesManager.getFavorites(for: selectedGender)) { name in
                    FavoriteRowView(
                        name: name,
                        themeColor: selectedGender.themeColor,
                        onTap: {
                            selectedName = name
                            showingNameDetail = true
                        },
                        onRemove: {
                            withAnimation {
                                favoritesManager.removeFavorite(name)
                            }
                        }
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Favorite Row View

struct FavoriteRowView: View {
    let name: BabyName
    let themeColor: Color
    let onTap: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name.name)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.textPrimary)

                Text(name.meaning)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            // Share button
            ShareLink(item: "\(name.name) - \(name.meaning)") {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 18))
                    .foregroundColor(.textSecondary)
            }

            // Remove button
            Button(action: onRemove) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(themeColor.opacity(0.3))
                .background(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .onTapGesture(perform: onTap)
    }
}

// MARK: - Preview

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
