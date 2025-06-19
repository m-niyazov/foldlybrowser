//
//  OnboardingRemoteSettings.swift
//  foldlybrowser+
//
//  Created by m-niyazov on 31.05.2023.
//

import Foundation

enum OnboardingVersion: String, Codable {
    // swiftlint: disable identifier_name
    case v1_1
    // swiftlint: enable identifier_name
}

struct OnboardingRemoteSettings: Codable {
    let onboardingVersion: OnboardingVersion
    let paywallId: String
}
