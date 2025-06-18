//
//  TabBarCoordinator.swift
//  body-temperature
//
//  Created by user on 08.12.2022.
//

import XCoordinator
import SnapKit
import UIKit

enum TabRoute: Route {
    case home
}

final class TabCoordinator: TabBarCoordinator<TabRoute> {
    private let dependencies: Dependencies
    private let homeRouter: StrongRouter<HomeRoute>

    convenience init(dependencies: Dependencies) {
        let homeCoordinator = HomeCoordinator(dependencies: dependencies)

        self.init(
            dependencies: dependencies,
            homeRouter: homeCoordinator.strongRouter
        )
        setupTabBarAppearance()
    }

    init(dependencies: Dependencies,
         homeRouter: StrongRouter<HomeRoute>) {
        self.dependencies = dependencies
        self.homeRouter = homeRouter
        super.init(tabs: [homeRouter], select: homeRouter)
    }

    override func prepareTransition(for route: TabRoute) -> TabBarTransition {
        switch route {
        case .home:
            return .select(homeRouter)
        }
    }

    private func setupTabBarAppearance() {
//        rootViewController.view.backgroundColor = Colors.mainBackground.color
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }

//        rootViewController.tabBar.tintColor = Colors.white.color
//        rootViewController.tabBar.backgroundColor = Colors.mainBackground.color
    }

    private func paywallCoordinator(_ context: PaywallContext) -> PaywallCoordinator {
        let paywall = PaywallCoordinator(dependencies: dependencies, context: context)
        return paywall
    }
}
