//
//  UserDefaultsApplicationState.swift
//  voltyplus
//
//  Created by niyazovv on 10.05.2024.
//

import Foundation

protocol UserDefaultsState {
    var hasBeenLaunchedBefore: Bool { get set }
    var isOnboardingCompleted: Bool { get set }
}

final class UserDefaultsStateImplementation: UserDefaultsState {
    var hasBeenLaunchedBefore: Bool {
        get { UserDefaults.standard.bool(forKey: .hasBeenLaunchedBefore) }
        set { UserDefaults.standard.set(newValue, forKey: .hasBeenLaunchedBefore) }
    }
    var isOnboardingCompleted: Bool {
        get { UserDefaults.standard.bool(forKey: .onboardingCompleted) }
        set { UserDefaults.standard.set(newValue, forKey: .onboardingCompleted) }
    }
}

// MARK: - UserDefaults Keys
private extension String {
    static let hasBeenLaunchedBefore = "hasBeenLaunchedBefore"
    static let onboardingCompleted = "onboardingCompleted"
}
