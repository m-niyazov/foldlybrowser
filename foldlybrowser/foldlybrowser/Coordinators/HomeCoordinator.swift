//
//  MainCoordinator.swift
//  absurdino
//
//  Created by Niyazov on 29.11.2022.
//

import UIKit
import XCoordinator

enum HomeRoute: Route {
    case home
    case paywall
    case alert(Alert)
    case appReview
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
            let home = UIViewController()
            home.view.backgroundColor = .yellow
            return .set([home])
        case .paywall:
            let paywall = paywallCoordinator()
            return .present(paywall)
        case .alert(let alert):
            return .presentAlert(alert)
        case .appReview:
            return .appReview()
        }
    }

    private func paywallCoordinator() -> PaywallCoordinator {
        let paywall = PaywallCoordinator(dependencies: dependencies, context: .main)
        return paywall
    }
}
