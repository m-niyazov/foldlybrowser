//
//  MainCoordinator.swift
//  foldlybrowser
//
//  Created by Niyazov on 29.11.2022.
//

import UIKit
import XCoordinator

enum HomeRoute: Route {
    case home
    case webpage(requestString: String)
    case paywall
    case alert(Alert)
    case appReview
    case settings
}

final class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home:
            let home = home()
            return .set([home])
        case .paywall:
            let paywall = paywallCoordinator()
            return .present(paywall)
        case .alert(let alert):
            return .presentAlert(alert)
        case .appReview:
            return .appReview()
        case .webpage(let requestString):
            let webpage = webpage(requestString: requestString)
            return .embed(
                webpage, in: (rootViewController.visibleViewController as? HomeViewController)!.webPageContainerView
            )
        case .settings:
            let settings = settingsCoordinator()
            return .presentFullScreen(settings)
        }
    }
    
    private func paywallCoordinator() -> PaywallCoordinator {
        let paywall = PaywallCoordinator(dependencies: dependencies, context: .main)
        return paywall
    }
    
    private func home() -> HomeViewController {
        return HomeBuilder.build(router: weakRouter)
    }
    
    private func webpage(requestString: String) -> WebpageViewController {
        return WebpageBuilder.build(router: weakRouter, requestString: requestString)
    }
    
    private func settingsCoordinator() -> SettingsCoordinator {
        let settings = SettingsCoordinator(dependencies: dependencies)
        return settings
    }
}
