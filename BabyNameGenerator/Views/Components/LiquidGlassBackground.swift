//
//  LiquidGlassBackground.swift
//  BabyNameGenerator
//
//  Animated gradient background with liquid glass aesthetic
//

import SwiftUI

struct LiquidGlassBackground: View {
    let colors: [Color]
    @State private var animateGradient = false

    var body: some View {
        ZStack {
            // Main gradient
            LinearGradient(
                colors: colors,
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
            .ignoresSafeArea()

            // Optional: Floating glass bubbles
            FloatingBubbles(color: colors.first ?? .white)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// MARK: - Floating Bubbles Effect

struct FloatingBubbles: View {
    let color: Color
    @State private var positions: [CGPoint] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<5, id: \.self) { index in
                    Circle()
                        .fill(color.opacity(0.08))
                        .frame(width: CGFloat.random(in: 80...200))
                        .blur(radius: 30)
                        .offset(
                            x: positions.indices.contains(index) ? positions[index].x : 0,
                            y: positions.indices.contains(index) ? positions[index].y : 0
                        )
                }
            }
            .onAppear {
                // Initialize random positions
                positions = (0..<5).map { _ in
                    CGPoint(
                        x: CGFloat.random(in: -geometry.size.width/2...geometry.size.width/2),
                        y: CGFloat.random(in: -geometry.size.height/2...geometry.size.height/2)
                    )
                }

                // Animate positions
                withAnimation(
                    .easeInOut(duration: 8.0)
                    .repeatForever(autoreverses: true)
                ) {
                    positions = (0..<5).map { _ in
                        CGPoint(
                            x: CGFloat.random(in: -geometry.size.width/2...geometry.size.width/2),
                            y: CGFloat.random(in: -geometry.size.height/2...geometry.size.height/2)
                        )
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Preview

struct LiquidGlassBackground_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LiquidGlassBackground(colors: Gender.girl.gradientColors)
        }
    }
}
