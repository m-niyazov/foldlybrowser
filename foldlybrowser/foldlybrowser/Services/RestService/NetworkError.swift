//
//  APIError.swift
//  ProSport
//
//  Created by m.TapticGroup on 27.03.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case serverError
    case noInternetConnection
    case unableToDecode
    case unauthorized
    case tokenExpired
    case userChatEmpty
    case customError(error: CustomError)

    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Strings.NetworkError.server"
        case .noInternetConnection:
            return "Strings.NetworkError.noInternetConnection"
        case .unableToDecode:
            return "Strings.NetworkError.unableToDecode"
        case .unauthorized:
            return "Strings.NetworkError.unauthorized"
        case .tokenExpired:
            return "Strings.NetworkError.tokenExpired"
        case .customError(let error):
            return error.message
        case .userChatEmpty:
            return "Strings.NetworkError.server"
        }
    }
}

struct CustomError: Error, Codable {
    var message: String
    var code: Int = 0
}
