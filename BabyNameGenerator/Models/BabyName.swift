//
//  BabyName.swift
//  BabyNameGenerator
//
//  Model representing a baby name with its meaning and metadata
//

import Foundation

struct BabyName: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let meaning: String
    let gender: Gender
    let origin: String

    /// Initializer with automatic UUID generation
    init(id: UUID = UUID(), name: String, meaning: String, gender: Gender, origin: String = "Traditional") {
        self.id = id
        self.name = name
        self.meaning = meaning
        self.gender = gender
        self.origin = origin
    }

    /// Coding keys for JSON serialization
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case meaning
        case gender
        case origin
    }
}

// MARK: - Sample Data for Previews

extension BabyName {
    static let sampleGirl = BabyName(
        name: "Altansarnai",
        meaning: "Golden Rose",
        gender: .girl,
        origin: "Traditional"
    )

    static let sampleBoy = BabyName(
        name: "Baatar",
        meaning: "Hero",
        gender: .boy,
        origin: "Traditional"
    )

    static let samples: [BabyName] = [
        sampleGirl,
        sampleBoy,
        BabyName(name: "Sarangerel", meaning: "Moonlight", gender: .girl),
        BabyName(name: "Temujin", meaning: "Iron", gender: .boy),
        BabyName(name: "Oyuun", meaning: "Wisdom", gender: .girl)
    ]
}
