//
//  SettingsBuilder.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit
import XCoordinator

final class SettingsBuilder {
    static func build(
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService,
        subscriptionService: SubscriptionService
    ) -> SettingsViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(
            view: view,
            router: router,
            analyticService: analyticService,
            subscriptionService: subscriptionService
        )
        view.presenter = presenter
        return view
    }
}
