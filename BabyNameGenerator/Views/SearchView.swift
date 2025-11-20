//
//  SearchView.swift
//  BabyNameGenerator
//
//  Search and filter view for browsing all names
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedGender: Gender = .girl
    @State private var selectedOrigin: String = "All"
    @State private var sortOption: SortOption = .alphabetical
    @State private var selectedName: BabyName?
    @State private var showingNameDetail = false

    @ObservedObject var favoritesManager = FavoritesManager.shared
    private let repository = NameRepository()

    enum SortOption: String, CaseIterable {
        case alphabetical = "A-Z"
        case reverseAlphabetical = "Z-A"
        case shortest = "Shortest"
        case longest = "Longest"
    }

    var filteredNames: [BabyName] {
        var names = repository.getNames(for: selectedGender)

        // Filter by search text
        if !searchText.isEmpty {
            names = names.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.meaning.localizedCaseInsensitiveContains(searchText)
            }
        }

        // Filter by origin
        if selectedOrigin != "All" {
            names = names.filter { $0.origin == selectedOrigin }
        }

        // Sort
        switch sortOption {
        case .alphabetical:
            names.sort { $0.name < $1.name }
        case .reverseAlphabetical:
            names.sort { $0.name > $1.name }
        case .shortest:
            names.sort { $0.name.count < $1.name.count }
        case .longest:
            names.sort { $0.name.count > $1.name.count }
        }

        return names
    }

    var origins: [String] {
        let allOrigins = repository.getNames(for: selectedGender).map { $0.origin }
        return ["All"] + Array(Set(allOrigins)).sorted()
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LiquidGlassBackground(colors: selectedGender.gradientColors)
                    .animation(.easeInOut(duration: 0.8), value: selectedGender)

                VStack(spacing: 16) {
                    // Search bar
                    searchBar

                    // Filters
                    filtersSection

                    // Results count
                    Text("\(filteredNames.count) names found")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(.textSecondary)

                    // Names list
                    namesList
                }
            }
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingNameDetail) {
            if let name = selectedName {
                NameDetailView(name: name)
            }
        }
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.textSecondary)

            TextField("Search names or meanings...", text: $searchText)
                .font(.system(size: 16, design: .rounded))

            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.5))
                .background(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }

    // MARK: - Filters Section

    private var filtersSection: some View {
        VStack(spacing: 12) {
            // Gender toggle
            GenderToggle(
                selectedGender: $selectedGender,
                onToggle: { gender in
                    selectedGender = gender
                }
            )

            // Filter pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    // Origin filter
                    Menu {
                        ForEach(origins, id: \.self) { origin in
                            Button(origin) {
                                selectedOrigin = origin
                            }
                        }
                    } label: {
                        FilterPill(
                            label: "Origin: \(selectedOrigin)",
                            isActive: selectedOrigin != "All"
                        )
                    }

                    // Sort option
                    Menu {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                sortOption = option
                            }
                        }
                    } label: {
                        FilterPill(
                            label: "Sort: \(sortOption.rawValue)",
                            isActive: true
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Names List

    private var namesList: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(filteredNames) { name in
                    SearchResultRow(
                        name: name,
                        themeColor: selectedGender.themeColor,
                        isFavorite: favoritesManager.isFavorite(name),
                        onTap: {
                            selectedName = name
                            showingNameDetail = true
                        },
                        onFavorite: {
                            favoritesManager.toggleFavorite(name)
                        }
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Filter Pill

struct FilterPill: View {
    let label: String
    let isActive: Bool

    var body: some View {
        Text(label)
            .font(.system(size: 14, weight: .medium, design: .rounded))
            .foregroundColor(isActive ? .textPrimary : .textSecondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isActive ? Color.white.opacity(0.6) : Color.white.opacity(0.3))
            )
            .overlay(
                Capsule()
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
    }
}

// MARK: - Search Result Row

struct SearchResultRow: View {
    let name: BabyName
    let themeColor: Color
    let isFavorite: Bool
    let onTap: () -> Void
    let onFavorite: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(name.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.textPrimary)

                Text(name.meaning)
                    .font(.system(size: 13, design: .rounded))
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            Text(name.origin)
                .font(.system(size: 11, design: .rounded))
                .foregroundColor(.textSecondary.opacity(0.7))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white.opacity(0.3))
                .cornerRadius(8)

            Button(action: onFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 18))
                    .foregroundColor(isFavorite ? .red : .textSecondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(themeColor.opacity(0.2))
                .background(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .onTapGesture(perform: onTap)
    }
}

// MARK: - Preview

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
