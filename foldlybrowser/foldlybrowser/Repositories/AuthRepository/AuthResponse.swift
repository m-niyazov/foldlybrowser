//
//  AuthResponse.swift
//  foldlybrowser
//
//  Created by TapticGroup on 27.03.2025.
//

import Foundation

struct AuthResponse {
    struct SignInAnonymously: Codable {
        let idToken: String
        let refreshToken: String
        let localId: String
    }

    struct User: Codable {
        let firebaseUserId: String
        let appHudUserId: String
        let created: String
        let regionCode: String
    }

    struct RefreshToken: Codable {
        let expiresIn: String
        let tokenType: String
        let refreshToken: String
        let idToken: String
        let userId: String
        let projectId: String
    }
}
