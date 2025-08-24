//
//  MainCoordinator.swift
//  foldlybrowser
//
//  Created by Niyazov on 29.11.2022.
//

import UIKit
import Foundation
import XCoordinator

enum HomeRoute: Route {
    case home
    case webpage(requestString: String)
    case webpageSaving(url: URL, title: String)
    case dismissWebpage
    case paywall
    case alert(Alert)
    case appReview
    case settings
}

final class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    private let dependencies: Dependencies
    private var embeddedWebpageController: WebpageViewController?
  
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
            embeddedWebpageController = webpage
            return .embed(
                webpage, in: (rootViewController.visibleViewController as? HomeViewController)!.webPageContainerView
            )
        case .webpageSaving(let url, let title):
            let webPageSaving = webpageSaving(url, title: title)
            return .present(webPageSaving)
        case .dismissWebpage:
            embeddedWebpageController?.willMove(toParent: nil)
            embeddedWebpageController?.view.removeFromSuperview()
            embeddedWebpageController?.removeFromParent()
            embeddedWebpageController = nil
            return .none()
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
        return HomeBuilder.build(
            router: weakRouter,
            userDefaultState: dependencies.userDefaultState
        )
    }
    
    private func webpage(requestString: String) -> WebpageViewController {
        return WebpageBuilder.build(
            router: weakRouter,
            requestString: requestString,
            userDefaultState: dependencies.userDefaultState
        )
    }

    private func webpageSaving(_ url: URL, title: String) -> UIViewController {
        return UINavigationController(
            rootViewController: WebpageSavingBuilder.build(
                router: weakRouter,
                webPageUrl: url,
                webPageTitle: title,
                userDefaultState: dependencies.userDefaultState
        ))
    }


    private func settingsCoordinator() -> SettingsCoordinator {
        let settings = SettingsCoordinator(dependencies: dependencies)
        return settings
    }
}
