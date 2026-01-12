// 
//  WebpageSavingBuilder.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import UIKit
import XCoordinator

final class WebpageSavingBuilder {
    
    static func build(
        router: WeakRouter<HomeRoute>,
        webPageUrl: URL,
        webPageTitle: String,
        userDefaultState: UserDefaultsState
    ) -> WebpageSavingViewController {
        let view = WebpageSavingViewController()
        let presenter = WebpageSavingPresenter(
            view: view,
            router: router,
            webPageUrl: webPageUrl,
            webPageTitle: webPageTitle,
            userDefaultState: userDefaultState
        )

        view.presenter = presenter
        return view
    }
}
