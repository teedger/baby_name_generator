//
//  FavoritesManager.swift
//  BabyNameGenerator
//
//  Manager for persisting favorite names using UserDefaults
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()

    @Published var favorites: [BabyName] = []

    private let favoritesKey = "savedFavorites"

    private init() {
        loadFavorites()
    }

    // MARK: - Public Methods

    /// Add a name to favorites
    func addFavorite(_ name: BabyName) {
        guard !isFavorite(name) else { return }
        favorites.append(name)
        saveFavorites()
    }

    /// Remove a name from favorites
    func removeFavorite(_ name: BabyName) {
        favorites.removeAll { $0.id == name.id }
        saveFavorites()
    }

    /// Toggle favorite status
    func toggleFavorite(_ name: BabyName) {
        if isFavorite(name) {
            removeFavorite(name)
        } else {
            addFavorite(name)
        }
    }

    /// Check if name is favorited
    func isFavorite(_ name: BabyName) -> Bool {
        favorites.contains { $0.id == name.id }
    }

    /// Get favorites filtered by gender
    func getFavorites(for gender: Gender) -> [BabyName] {
        favorites.filter { $0.gender == gender }
    }

    /// Get count of favorites by gender
    func getCount(for gender: Gender) -> Int {
        getFavorites(for: gender).count
    }

    /// Clear all favorites
    func clearAll() {
        favorites.removeAll()
        saveFavorites()
    }

    // MARK: - Persistence

    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("❌ Error saving favorites: \(error)")
        }
    }

    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return
        }

        do {
            favorites = try JSONDecoder().decode([BabyName].self, from: data)
            print("✅ Loaded \(favorites.count) favorites")
        } catch {
            print("❌ Error loading favorites: \(error)")
        }
    }
}
