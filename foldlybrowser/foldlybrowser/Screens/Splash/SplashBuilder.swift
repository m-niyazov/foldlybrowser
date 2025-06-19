// 
//  SplashBuilder.swift
//  foldlybrowser
//
//  Created by Niyazov on 13.02.2023.
//

import UIKit
import XCoordinator

final class SplashBuilder {
    static func build(
        router: WeakRouter<RootRoute>,
        analyticService: CompositionalAnalyticService,
        subscriptionService: SubscriptionService,
        remoteConfigService: RemoteConfigService,
        applicationState: UserDefaultsState,
        authRepository: AuthRepository,
        attPermissionService: ATTPermissionService) -> SplashViewController {
        let view = SplashViewController()
        let presenter = SplashPresenter(
            view: view,
            router: router,
            analyticService: analyticService,
            subscriptionService: subscriptionService,
            remoteConfigService: remoteConfigService,
            applicationState: applicationState,
            authRepository: authRepository,
            attPermissionService: attPermissionService)
        view.presenter = presenter
        return view
    }
}
