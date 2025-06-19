//
//  ChatTarget.swift
//  foldlybrowser
//
//  Created by TapticGroup on 27.03.2025.
//

import Foundation
import Moya
import ApphudSDK
import KeychainSwift
import FirebaseAppCheck

protocol AppCheckToken {
    var appCheckToken: String { get }
}

struct CreateBase: AppCheckToken {
    let emojis: String
    let userLocale: String
    let appCheckToken: String
}

struct CreateImage: AppCheckToken {
    let textToImage: String
    let appCheckToken: String
}

struct CreateAudio: AppCheckToken {
    let textToAudio: String
    let userLocale: String
    let appCheckToken: String
}

enum GenerationTarget {
    case createBase(CreateBase)
    case createImage(CreateImage)
    case createAudio(CreateAudio)
}

extension GenerationTarget: TargetType {
    var baseURL: URL {
        // return .init(string: "http://127.0.0.1:8000/foldlybrowser/v1/")!
        return .init(string: "https://api.tapticgroup.com/foldlybrowser/v1/")!
    }

    @MainActor var path: String {
        switch self {
        case .createBase:
            return "create/"
        case .createImage:
            return "image/"
        case .createAudio:
            return "audio/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createBase, .createImage, .createAudio:
            return .post
        }
    }

    @MainActor var task: Task {
        let idTokenFirebase = KeychainSwift().get(KeychainKeys.idTokenFirebase) ?? String()
        switch self {
        case .createBase(let baseModel):
            return .requestParameters(
                parameters: [
                    "emojis": baseModel.emojis,
                    "userLocal": baseModel.userLocale
                ], encoding: JSONEncoding.default)
        case .createImage(let imageModel):
            return .requestParameters(
                parameters: [
                    "textToImage": imageModel.textToImage
                ], encoding: JSONEncoding.default)
        case .createAudio(let audioModel):
            return .requestParameters(
                parameters: [
                    "textToAudio": audioModel.textToAudio,
                    "userLocale": audioModel.userLocale
                ], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        var headerFields: [String: String] = [:]
        switch self {
        case let .createBase(baseModel):
            headerFields["X-Firebase-AppCheck"] = baseModel.appCheckToken
            return headerFields
        case let .createImage(imageModel):
            headerFields["X-Firebase-AppCheck"] = imageModel.appCheckToken
            return headerFields
        case let .createAudio(audioModel):
            headerFields["X-Firebase-AppCheck"] = audioModel.appCheckToken
            return headerFields
        }
    }
}
