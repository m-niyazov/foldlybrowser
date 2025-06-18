//
//  PaywallCoordinator.swift
//  absurdino
//
//  Created by Niyazov on 13.02.2023.
//

import Foundation
import XCoordinator
import UIKit

enum PaywallRoute: Route {
    case paywall
    case webView(URL, String)
    case alert(Alert)
    case spAlert(SPAlertConfig)
    case close
}

enum PaywallContext: String {
    case onboarding
    case main
    case settings
}

protocol PaywallCoordinatorOutput: AnyObject {
    func routeToMainFromPaywall()
}

final class PaywallCoordinator: ViewCoordinator<PaywallRoute> {
    private let dependencies: Dependencies
    private var context: PaywallContext

    weak var paywallCoordinatorOutput: PaywallCoordinatorOutput?

    init(dependencies: Dependencies, context: PaywallContext) {
        self.dependencies = dependencies
        self.context = context

        let emptyViewController = UIViewController()
        emptyViewController.view.backgroundColor = .none
        super.init(
            rootViewController: emptyViewController,
            initialRoute: .paywall
        )
    }

    override func prepareTransition(for route: PaywallRoute) -> ViewTransition {
        switch route {
        case .paywall:
//            let paywallViewController = paywall(context: context)
            return .none()
        case let .webView(urlLink, navigationTitle):
//            let webView = webView(urlLink, navigationTitle)
            return .none()
        case let .alert(alert):
            return .presentAlert(alert)
        case .spAlert(let spAlert):
            return .presentSPAlert(spAlert)
        case .close:
            switch context {
            case .onboarding:
                paywallCoordinatorOutput?.routeToMainFromPaywall()
                return .none()
            default:
                return .dismiss()
            }
        }
    }

//    private func paywall(context: PaywallContext) -> UIViewController {
//        let paywall = PaywallBuilder.build(
//            router: weakRouter,
//            applicationState: dependencies.applicationState,
//            subscriptionService: dependencies.subscriptionService,
//            creditBalanceManager: dependencies.creditBalanceManager,
//            analyticService: dependencies.analyticService,
//            remoteConfig: dependencies.remoteConfig,
//            context: context
//        )
//        return paywall
//    }
//
//    func webView(_ url: URL, _ navigationTitle: String) -> UIViewController {
//        let webView = WebViewBuilder.build(url, navigationTitle)
//        return UINavigationController(rootViewController: webView)
//    }
}
