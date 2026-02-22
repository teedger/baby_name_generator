//
//  SignInView.swift
//  BabyNameGenerator
//
//  Sign in with Apple authentication screen
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @ObservedObject var authManager = AuthManager.shared

    var body: some View {
        ZStack {
            LiquidGlassBackground(colors: Gender.girl.gradientColors)

            VStack(spacing: 40) {
                Spacer()

                // App icon area
                ZStack {
                    Circle()
                        .fill(Color.babyGirl.opacity(0.3))
                        .frame(width: 120, height: 120)

                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.babyGirlAccent)
                }

                // Welcome text
                VStack(spacing: 12) {
                    Text("Baby Names")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.textPrimary)

                    Text("Discover beautiful Mongolian\nnames for your baby")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                // Sign in with Apple button
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    authManager.handleSignIn(result: result)
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 54)
                .cornerRadius(16)
                .padding(.horizontal, 40)

                // Continue as guest button
                Button(action: { authManager.signInAsGuest() }) {
                    Text("Continue as Guest")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.glassBackground)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.glassBorder, lineWidth: 1)
                        )
                }
                .padding(.horizontal, 40)

                Text("Your data stays on your device")
                    .font(.system(size: 13, design: .rounded))
                    .foregroundColor(.textSecondary.opacity(0.7))

                Spacer()
                    .frame(height: 40)
            }
        }
    }
}

// MARK: - Preview

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
