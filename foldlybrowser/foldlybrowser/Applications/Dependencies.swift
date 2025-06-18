//
//  Dependencies.swift
//  foldlybrowser
//
//  Created by TapticGroup on 16/06/2025.
//

import Foundation
extension SceneDelegate {
    func dependencies() -> Dependencies {
        let userDefaultState = UserDefaultsStateImplementation()
        let firebaseRemoteConfig = FirebaseRemoteConfig()

        let amplitudeAnalyticService = AmplitudeAnalyticService()
        let compositionalAnalyticService = CompositionalAnalyticService(
            analyticServices: [amplitudeAnalyticService]
        )

        let appHudSubscriptionService = ApphudSubscriptionService()

        let attPermissionService = ATTPermissionService(
            analyticService: compositionalAnalyticService
        )
        let authRepository = AuthRepositoryImpl()
        let notificationPermissionService = NotificationsPermissionService(
            analyticService: compositionalAnalyticService
        )

        return Dependencies(
            userDefaultState: userDefaultState,
            remoteConfig: firebaseRemoteConfig,
            analyticService: compositionalAnalyticService,
            authRepository: authRepository,
            subscriptionService: appHudSubscriptionService,
            attPermissionService: attPermissionService,
            notificationPermissionService: notificationPermissionService
        )
    }
}

struct Dependencies {
    var userDefaultState: UserDefaultsState
    var remoteConfig: FirebaseRemoteConfig
    var analyticService: CompositionalAnalyticService
    let authRepository: AuthRepository
    let subscriptionService: SubscriptionService
    var attPermissionService: ATTPermissionService
    var notificationPermissionService: NotificationsPermissionService
}
