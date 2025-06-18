//
//  AuthRepository.swift
//  tralala-creator
//
//  Created by TapticGroup on 27.03.2025.
//
import Foundation
import KeychainSwift

protocol AuthRepository {
    typealias Handler<T> = (Result<T, NetworkError>) -> Void

    var isNeedToSignUp: Bool { get }

    func isNeedToRefreshToken() -> Bool

    func signUp(completion: @escaping Handler<AuthResponse.SignInAnonymously>)
    func refreshToken(completion: @escaping Handler<AuthResponse.RefreshToken>)
}

final class AuthRepositoryImpl: AuthRepository {
    // MARK: - Properties

    var isNeedToSignUp: Bool {
        return KeychainSwift().get(KeychainKeys.firebaseUUDID) == nil
    }

    func isNeedToRefreshToken() -> Bool {
        return isIdTokenExpired()
    }

    private var restClient = MoyaRestClient<AuthTarget>()

    // MARK: - Initialize
    init() {
    }

    // MARK: - Methods

    func signUp(completion: @escaping Handler<AuthResponse.SignInAnonymously>) {
        restClient.load(from: .signUpAnonymously) { response in
            completion(.success(response))
            KeychainSwift().set(response.localId, forKey: KeychainKeys.firebaseUUDID)
            KeychainSwift().set(response.idToken, forKey: KeychainKeys.idTokenFirebase)
            KeychainSwift().set(response.refreshToken, forKey: KeychainKeys.refreshTokenFirebase)
        } failure: { error in
            completion(.failure(error))
        }
    }

    func refreshToken(completion: @escaping Handler<AuthResponse.RefreshToken>) {
        guard let refreshToken = KeychainSwift().get(KeychainKeys.refreshTokenFirebase) else {
            completion(.failure(.tokenExpired))
            return
        }

        restClient.load(from: .refreshToken) { response in
            completion(.success(response))
            KeychainSwift().set(response.idToken, forKey: KeychainKeys.idTokenFirebase)
            KeychainSwift().set(response.refreshToken, forKey: KeychainKeys.refreshTokenFirebase)
            KeychainSwift().set(response.userId, forKey: KeychainKeys.firebaseUUDID)
        } failure: { error in
            completion(.failure(error))
        }
    }

    // Публичный метод для проверки истечения idToken
    func isIdTokenExpired() -> Bool {
        guard let idToken = KeychainSwift().get(KeychainKeys.idTokenFirebase) else {
            return true
        }
        return isIdTokenExpired(idToken)
    }

    // Приватный метод для проверки конкретного idToken
    private func isIdTokenExpired(_ idToken: String) -> Bool {
        let segments = idToken.split(separator: ".")
        guard segments.count == 3 else { return true }

        let payloadSegment = String(segments[1])
        var base64 = payloadSegment.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64 += "="
        }

        guard let payloadData = Data(base64Encoded: base64),
              let payload = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any],
              let exp = payload["exp"] as? NSNumber else {
            return true
        }

        let expirationDate = Date(timeIntervalSince1970: exp.doubleValue)
        return Date() > expirationDate
    }
}
