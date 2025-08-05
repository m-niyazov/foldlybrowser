//
//  SettingsSearchEngineBuilder.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit
import XCoordinator

final class SettingsSearchEngineBuilder {
    static func build(
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService
    ) -> SettingsSearchEngineViewController {
        let view = SettingsSearchEngineViewController()
        let presenter = SettingsSearchEnginePresenter(
            view: view,
            router: router,
            analyticService: analyticService
        )
        view.presenter = presenter
        return view
    }
}
