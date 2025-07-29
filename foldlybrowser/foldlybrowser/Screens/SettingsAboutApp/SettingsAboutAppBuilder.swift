//
//  SettingsAboutAppBuilder.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit
import XCoordinator

final class SettingsAboutAppBuilder {
    static func build(
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService
    ) -> SettingsAboutAppViewController {
        let view = SettingsAboutAppViewController()
        let presenter = SettingsAboutAppPresenter(
            view: view,
            router: router,
            analyticService: analyticService
        )
        view.presenter = presenter
        return view
    }
}
