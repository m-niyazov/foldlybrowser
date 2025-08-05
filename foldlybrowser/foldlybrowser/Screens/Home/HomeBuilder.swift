// 
//  HomeBuilder.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import UIKit
import XCoordinator

final class HomeBuilder {
    
    static func build(
        router: WeakRouter<HomeRoute>,
        userDefaultState: UserDefaultsState
    ) -> HomeViewController {
        let view = HomeViewController()
        let presenter = HomePresenter(
            view: view,
            router: router,
            userDefaultState: userDefaultState
        )

        view.presenter = presenter
        return view
    }
}
