//
//  NameGeneratorViewModel.swift
//  BabyNameGenerator
//
//  ViewModel managing name generation logic and state
//

import Foundation
import SwiftUI

class NameGeneratorViewModel: ObservableObject {
    // MARK: - Published Properties

    /// Currently displayed name
    @Published var currentName: BabyName?

    /// Selected gender (girl or boy)
    @Published var selectedGender: Gender = .girl

    /// Whether animation is in progress
    @Published var isAnimating: Bool = false

    // MARK: - Private Properties

    private let repository: NameRepository
    private var previousNameIDs: Set<UUID> = []
    private let maxHistorySize = 5

    // MARK: - Initialization

    init(repository: NameRepository = NameRepository()) {
        self.repository = repository
        // Generate initial name
        generateRandomName()
    }

    // MARK: - Public Methods

    /// Generate a random name for the currently selected gender
    func generateRandomName() {
        // Start animation
        isAnimating = true

        // Get available names (excluding recent ones to avoid repeats)
        let availableNames = repository.getNames(for: selectedGender)
            .filter { !previousNameIDs.contains($0.id) }

        // If all names have been shown recently, clear history
        guard let randomName = availableNames.randomElement() else {
            previousNameIDs.removeAll()
            generateRandomName()
            return
        }

        // Update current name
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            currentName = randomName
        }

        // Add to history
        previousNameIDs.insert(randomName.id)

        // Keep history size limited
        if previousNameIDs.count > maxHistorySize {
            // Remove oldest entry (convert to array, remove first, back to set)
            let historyArray = Array(previousNameIDs)
            previousNameIDs = Set(historyArray.suffix(maxHistorySize))
        }

        // End animation after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isAnimating = false
        }
    }

    /// Toggle gender and generate new name
    func toggleGender(to gender: Gender) {
        guard gender != selectedGender else { return }

        withAnimation(.easeInOut(duration: 0.8)) {
            selectedGender = gender
        }

        // Clear history when switching gender
        previousNameIDs.removeAll()

        // Generate new name for the selected gender
        generateRandomName()
    }

    /// Get statistics for current gender
    func getNameCount() -> Int {
        repository.getCount(for: selectedGender)
    }

    /// Get total name count
    func getTotalNameCount() -> Int {
        repository.getAllNames().count
    }
}
