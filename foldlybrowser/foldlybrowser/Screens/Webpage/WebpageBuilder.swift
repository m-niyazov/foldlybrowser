// 
//  WebpageBuilder.swift
//  foldlybrowser
//
//  Created by TapticGroup on 12/07/2025.
//

import UIKit
import XCoordinator

final class WebpageBuilder {
    
    static func build(
        router: WeakRouter<HomeRoute>,
        requestString: String,
        userDefaultState: UserDefaultsState) -> WebpageViewController {
        let view = WebpageViewController()
        let presenter = WebpagePresenter(
            view: view,
            router: router,
            requestString: requestString,
            userDefaultState: userDefaultState
        )

        view.presenter = presenter
        return view
    }
}
