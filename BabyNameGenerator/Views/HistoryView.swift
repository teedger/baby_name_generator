//
//  HistoryView.swift
//  BabyNameGenerator
//
//  View displaying name generation history
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var historyManager = HistoryManager.shared
    @ObservedObject var favoritesManager = FavoritesManager.shared
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

                    // History list
                    if historyManager.getHistory(for: selectedGender).isEmpty {
                        emptyStateView
                    } else {
                        historyListView
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !historyManager.history.isEmpty {
                        Button("Clear") {
                            historyManager.clearHistory()
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

            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 60))
                .foregroundColor(.textSecondary.opacity(0.5))

            Text("No History Yet")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.textPrimary)

            Text("Names you generate will\nappear here")
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
    }

    private var historyListView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(historyManager.getHistory(for: selectedGender)) { item in
                    HistoryRowView(
                        item: item,
                        themeColor: selectedGender.themeColor,
                        isFavorite: favoritesManager.isFavorite(item.name),
                        onTap: {
                            selectedName = item.name
                            showingNameDetail = true
                        },
                        onFavorite: {
                            favoritesManager.toggleFavorite(item.name)
                        }
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - History Row View

struct HistoryRowView: View {
    let item: HistoryManager.HistoryItem
    let themeColor: Color
    let isFavorite: Bool
    let onTap: () -> Void
    let onFavorite: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name.name)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.textPrimary)

                HStack(spacing: 8) {
                    Text(item.name.meaning)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(.textSecondary)

                    Text("•")
                        .foregroundColor(.textSecondary.opacity(0.5))

                    Text(timeAgo(from: item.timestamp))
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.textSecondary.opacity(0.7))
                }
            }

            Spacer()

            // Favorite button
            Button(action: onFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 20))
                    .foregroundColor(isFavorite ? .red : .textSecondary)
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
                .stroke(Color.glassBorder, lineWidth: 1)
        )
        .onTapGesture(perform: onTap)
    }

    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

// MARK: - Preview

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
