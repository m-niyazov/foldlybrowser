//
//  AuthTarget.swift
//  foldlybrowser
//
//  Created by TapticGroup on 27.03.2025.
//

import Foundation
import Moya
import KeychainSwift

enum AuthTarget {
    case signUpAnonymously
    case refreshToken
}

extension AuthTarget: TargetType {
    var baseURL: URL {
        switch self {
        case .signUpAnonymously:
            return .init(string: "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=\(AppConstants.firebaseWebApiKey)")!
        case .refreshToken:
            return .init(string: "https://securetoken.googleapis.com/v1/token?key=\(AppConstants.firebaseWebApiKey)")!
        }
    }

    var path: String {
        switch self {
        case .signUpAnonymously:
            return String()
        case .refreshToken:
            return String()
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUpAnonymously:
            return .post
        case .refreshToken:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .signUpAnonymously:
            return .requestParameters(
                parameters: [
                    "returnSecureToken": true
                ],
                encoding: JSONEncoding.default
            )
        case .refreshToken:
            let refreshToken = KeychainSwift().get(KeychainKeys.refreshTokenFirebase) ?? String()
            return .requestParameters(
                parameters: [
                    "grant_type": "refresh_token",
                    "refresh_token": refreshToken
                ],
                encoding: JSONEncoding.default
            )
        }
    }
}
