//
//  HistoryManager.swift
//  BabyNameGenerator
//
//  Manager for tracking name generation history
//

import Foundation
import Combine

class HistoryManager: ObservableObject {
    static let shared = HistoryManager()

    @Published var history: [HistoryItem] = []

    private let historyKey = "nameHistory"
    private let maxHistorySize = 100

    private init() {
        loadHistory()
    }

    // MARK: - History Item

    struct HistoryItem: Codable, Identifiable {
        let id: UUID
        let name: BabyName
        let timestamp: Date

        init(name: BabyName) {
            self.id = UUID()
            self.name = name
            self.timestamp = Date()
        }
    }

    // MARK: - Public Methods

    /// Add a name to history
    func addToHistory(_ name: BabyName) {
        let item = HistoryItem(name: name)
        history.insert(item, at: 0)

        // Trim history if too large
        if history.count > maxHistorySize {
            history = Array(history.prefix(maxHistorySize))
        }

        saveHistory()
    }

    /// Get history filtered by gender
    func getHistory(for gender: Gender) -> [HistoryItem] {
        history.filter { $0.name.gender == gender }
    }

    /// Get recent history (last N items)
    func getRecent(_ count: Int = 10) -> [HistoryItem] {
        Array(history.prefix(count))
    }

    /// Clear all history
    func clearHistory() {
        history.removeAll()
        saveHistory()
    }

    /// Get count by gender
    func getCount(for gender: Gender) -> Int {
        getHistory(for: gender).count
    }

    // MARK: - Persistence

    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(history)
            UserDefaults.standard.set(data, forKey: historyKey)
        } catch {
            print("❌ Error saving history: \(error)")
        }
    }

    private func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: historyKey) else {
            return
        }

        do {
            history = try JSONDecoder().decode([HistoryItem].self, from: data)
            print("✅ Loaded \(history.count) history items")
        } catch {
            print("❌ Error loading history: \(error)")
        }
    }
}
