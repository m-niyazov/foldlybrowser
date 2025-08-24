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
        url: URL,
        userDefaultState: UserDefaultsState
    ) -> WebpageSavingViewController {
        let view = WebpageSavingViewController()
        let presenter = WebpageSavingPresenter(
            view: view,
            router: router,
            url: url,
            userDefaultState: userDefaultState
        )

        view.presenter = presenter
        return view
    }
}
