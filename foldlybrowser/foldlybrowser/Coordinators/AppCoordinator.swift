//
//  AppCoordinator.swift
//  absurdino
//
//  Created by Niyazov on 20.11.2022.
//

import UIKit
import XCoordinator

enum RootRoute: Route {
    case splash
    case onboarding
    case paywall(PaywallContext)
    case tabBar
    case alert(Alert)
}

final class AppCoordinator: NavigationCoordinator<RootRoute> {
    private var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies

        let appViewController = UINavigationController(
            rootViewController: UIViewController()
        )
        appViewController.view.backgroundColor = .black
        appViewController.setNavigationBarHidden(true, animated: false)
        super.init(rootViewController: appViewController, initialRoute: .splash)
    }

    override func prepareTransition(for route: RootRoute) -> NavigationTransition {
        switch route {
        case .splash:
            let splash = splash()
            return .push(splash)
        case .onboarding:
            return .none()
        case .paywall(let context):
            let paywallCoordinator = paywallCoordinator(context)
            paywallCoordinator.paywallCoordinatorOutput = self
            return .push(paywallCoordinator, animation: .fade)
        case .tabBar:
            let tabBarCoordinator = tabBarCoordinator()
            return .multiple(
                .set([tabBarCoordinator], animation: .fade)
            )
        case .alert(let alert):
            return .presentAlert(alert)
        }
    }

    private func splash() -> UIViewController {
        let splash = SplashBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService,
            subscriptionService: dependencies.subscriptionService,
            remoteConfigService: dependencies.remoteConfig,
            applicationState: dependencies.userDefaultState,
            authRepository: dependencies.authRepository,
            attPermissionService: dependencies.attPermissionService)
        return splash
    }

    private func paywallCoordinator(_ context: PaywallContext) -> PaywallCoordinator {
        let paywall = PaywallCoordinator(dependencies: dependencies, context: context)
        return paywall
    }

    private func tabBarCoordinator() -> TabCoordinator {
        let tabBarCoordinator = TabCoordinator(dependencies: dependencies)
        return tabBarCoordinator
    }
}

extension AppCoordinator: PaywallCoordinatorOutput {
    func routeToMainFromPaywall() {
        trigger(.tabBar)
    }
}
