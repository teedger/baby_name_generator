//
//  AuthManager.swift
//  BabyNameGenerator
//
//  Manages Sign in with Apple authentication state
//

import Foundation
import AuthenticationServices

class AuthManager: ObservableObject {
    static let shared = AuthManager()

    @Published var isSignedIn: Bool
    @Published var isGuest: Bool
    @Published var userName: String?
    @Published var userEmail: String?

    private let userIDKey = "appleUserID"
    private let userNameKey = "appleUserName"
    private let userEmailKey = "appleUserEmail"
    private let isGuestKey = "isGuestUser"

    private init() {
        let guest = UserDefaults.standard.bool(forKey: isGuestKey)
        self.isGuest = guest
        self.isSignedIn = UserDefaults.standard.string(forKey: userIDKey) != nil || guest
        self.userName = guest ? "Guest" : UserDefaults.standard.string(forKey: userNameKey)
        self.userEmail = UserDefaults.standard.string(forKey: userEmailKey)
        checkAuthState()
    }

    func handleSignIn(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

            let userID = credential.user
            UserDefaults.standard.set(userID, forKey: userIDKey)

            // Apple only provides name/email on first sign-in
            if let fullName = credential.fullName {
                let name = [fullName.givenName, fullName.familyName]
                    .compactMap { $0 }
                    .joined(separator: " ")
                if !name.isEmpty {
                    userName = name
                    UserDefaults.standard.set(name, forKey: userNameKey)
                }
            }

            if let email = credential.email {
                userEmail = email
                UserDefaults.standard.set(email, forKey: userEmailKey)
            }

            isSignedIn = true

        case .failure(let error):
            print("Sign in with Apple failed: \(error.localizedDescription)")
        }
    }

    func signInAsGuest() {
        isGuest = true
        userName = "Guest"
        userEmail = nil
        UserDefaults.standard.set(true, forKey: isGuestKey)
        isSignedIn = true
    }

    func signOut() {
        UserDefaults.standard.removeObject(forKey: userIDKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: userEmailKey)
        UserDefaults.standard.removeObject(forKey: isGuestKey)
        isSignedIn = false
        isGuest = false
        userName = nil
        userEmail = nil
    }

    func checkAuthState() {
        if isGuest { return }

        guard let userID = UserDefaults.standard.string(forKey: userIDKey) else {
            isSignedIn = false
            return
        }

        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: userID) { [weak self] state, _ in
            DispatchQueue.main.async {
                switch state {
                case .authorized:
                    self?.isSignedIn = true
                case .revoked, .notFound:
                    self?.signOut()
                default:
                    break
                }
            }
        }
    }
}
