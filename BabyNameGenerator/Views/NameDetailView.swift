//
//  NameDetailView.swift
//  BabyNameGenerator
//
//  Full-screen detailed view of a baby name
//

import SwiftUI

struct NameDetailView: View {
    let name: BabyName
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LiquidGlassBackground(colors: name.gender.gradientColors)

                ScrollView {
                    VStack(spacing: 30) {
                        // Main name card
                        mainNameCard

                        // Details card
                        detailsCard

                        // Actions
                        actionsSection

                        Spacer(minLength: 50)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        favoritesManager.toggleFavorite(name)
                    }) {
                        Image(systemName: favoritesManager.isFavorite(name) ? "heart.fill" : "heart")
                            .foregroundColor(favoritesManager.isFavorite(name) ? .red : .primary)
                    }
                }
            }
        }
    }

    // MARK: - Main Name Card

    private var mainNameCard: some View {
        VStack(spacing: 16) {
            // Gender icon
            Image(systemName: name.gender == .girl ? "figure.stand.dress" : "figure.stand")
                .font(.system(size: 40))
                .foregroundColor(name.gender.themeColor)

            // Name
            Text(name.name)
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)

            // Meaning
            Text(name.meaning)
                .font(.system(size: 24, weight: .medium, design: .rounded))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(name.gender.themeColor.opacity(0.3))
                .background(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.glassBorder, lineWidth: 1)
        )
        .shadow(color: Color.shadowMedium, radius: 20, x: 0, y: 10)
    }

    // MARK: - Details Card

    private var detailsCard: some View {
        VStack(spacing: 16) {
            Text("Details")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 12) {
                DetailRow(label: "Gender", value: name.gender.displayName)
                DetailRow(label: "Origin", value: name.origin)
                DetailRow(label: "Letters", value: "\(name.name.count)")
                DetailRow(label: "Syllables", value: "\(estimateSyllables(name.name))")
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.glassCard)
                .background(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.glassBorder, lineWidth: 1)
        )
    }

    // MARK: - Actions Section

    private var actionsSection: some View {
        VStack(spacing: 12) {
            // Share button
            ShareLink(
                item: "\(name.name) - \(name.meaning)\n\nA beautiful Mongolian name meaning \"\(name.meaning)\"",
                subject: Text("Baby Name: \(name.name)"),
                message: Text("Check out this beautiful Mongolian baby name!")
            ) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share Name")
                }
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(name.gender.themeColor)
                .cornerRadius(16)
            }

            // Copy button
            Button(action: copyToClipboard) {
                HStack {
                    Image(systemName: "doc.on.doc")
                    Text("Copy Name")
                }
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.glassBackground)
                .cornerRadius(16)
            }
        }
    }

    // MARK: - Helper Methods

    private func estimateSyllables(_ text: String) -> Int {
        let vowels = CharacterSet(charactersIn: "aeiouAEIOU")
        var count = 0
        var previousWasVowel = false

        for char in text.unicodeScalars {
            let isVowel = vowels.contains(char)
            if isVowel && !previousWasVowel {
                count += 1
            }
            previousWasVowel = isVowel
        }

        return max(1, count)
    }

    private func copyToClipboard() {
        UIPasteboard.general.string = "\(name.name) - \(name.meaning)"

        // Haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// MARK: - Detail Row

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(.textSecondary)

            Spacer()

            Text(value)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.textPrimary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

struct NameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NameDetailView(name: BabyName.sampleGirl)
    }
}
