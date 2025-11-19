//
//  NameRepository.swift
//  BabyNameGenerator
//
//  Repository for loading and managing baby names from JSON data
//

import Foundation

class NameRepository {
    private var allNames: [BabyName] = []

    init() {
        loadNames()
    }

    /// Load names from JSON file
    private func loadNames() {
        guard let url = Bundle.main.url(forResource: "mongolian_names", withExtension: "json") else {
            print("❌ Error: Could not find mongolian_names.json")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let nameData = try decoder.decode(NameData.self, from: data)

            // Convert to BabyName objects with UUIDs
            allNames = nameData.names.map { nameItem in
                BabyName(
                    id: UUID(),
                    name: nameItem.name,
                    meaning: nameItem.meaning,
                    gender: nameItem.gender,
                    origin: nameItem.origin
                )
            }

            print("✅ Loaded \(allNames.count) names from database")
        } catch {
            print("❌ Error loading names: \(error.localizedDescription)")
        }
    }

    /// Get all names for a specific gender
    func getNames(for gender: Gender) -> [BabyName] {
        allNames.filter { $0.gender == gender }
    }

    /// Get all names
    func getAllNames() -> [BabyName] {
        allNames
    }

    /// Get count of names by gender
    func getCount(for gender: Gender) -> Int {
        getNames(for: gender).count
    }

    /// Get random name for a specific gender
    func getRandomName(for gender: Gender) -> BabyName? {
        getNames(for: gender).randomElement()
    }

    /// Get random name excluding specific IDs (to avoid repeats)
    func getRandomName(for gender: Gender, excluding excludedIDs: Set<UUID>) -> BabyName? {
        let availableNames = getNames(for: gender).filter { !excludedIDs.contains($0.id) }
        return availableNames.randomElement()
    }
}

// MARK: - JSON Decoding Structures

private struct NameData: Codable {
    let names: [NameItem]
}

private struct NameItem: Codable {
    let name: String
    let meaning: String
    let gender: Gender
    let origin: String
}
