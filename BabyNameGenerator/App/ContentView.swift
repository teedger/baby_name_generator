//
//  ContentView.swift
//  BabyNameGenerator
//
//  Root view of the application
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NameGeneratorView()
            .preferredColorScheme(.light) // Force light mode for v1.0
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
