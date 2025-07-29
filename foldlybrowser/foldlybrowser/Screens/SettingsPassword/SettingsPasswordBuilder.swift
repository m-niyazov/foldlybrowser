//
//  SettingsPasswordBuilder.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit
import XCoordinator

final class SettingsPasswordBuilder {
    static func build(
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService
    ) -> SettingsPasswordViewController {
        let view = SettingsPasswordViewController()
        let presenter = SettingsPasswordPresenter(
            view: view,
            router: router,
            analyticService: analyticService
        )
        view.presenter = presenter
        return view
    }
}
