//
//  SettingsAppearanceBuilder.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit
import XCoordinator

final class SettingsAppearanceBuilder {
    static func build(
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService
    ) -> SettingsAppearanceViewController {
        let view = SettingsAppearanceViewController()
        let presenter = SettingsAppearancePresenter(
            view: view,
            router: router,
            analyticService: analyticService
        )
        view.presenter = presenter
        return view
    }
}
