//
//  SettingsCoordinator.swift
//  foldlybrowser
//
//  Created by Niyazov on 21.02.2023.
//

import UIKit
import XCoordinator

enum SettingsRoute: Route {
    case settings
    case settingsAppearance
    case settingsPassword
    case settingsAboutApp
    case paywall
    case shareApp
    case dismiss
    case chatTab
    case profile(UIAlertController)
    case alert(Alert)
    case spAlert(SPAlertConfig)
    case webView(URL, String)
    case openSafari(URL)
}

final class SettingsCoordinator: NavigationCoordinator<SettingsRoute> {
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(initialRoute: .settings)
    }

    override func prepareTransition(for route: SettingsRoute) -> NavigationTransition {
        switch route {
        case .settings:
            let settings = settings()
            return .set([settings])
        case .paywall:
            let paywall = paywallCoordinator()
            return .present(paywall)
        case .shareApp:
       //     let ac = UIActivityViewController(activityItems: [AppConstants.appStoreURL], applicationActivities: nil)
          //  return .present(ac)
            return .none()
        case .dismiss:
            return .dismiss()
        case .chatTab:
            rootViewController.tabBarController?.selectedIndex = 0
            return .none()
        case .profile(let alertController):
            return .present(alertController)
        case .alert(let alert):
            return .presentAlert(alert)
        case .spAlert(let spAlert):
            return .presentSPAlert(spAlert)
        case let .webView(urlLink, navigationTitle):
            let webView = webView(urlLink, navigationTitle)
            return .none()
        case .openSafari(let url):
            return .openSafari(url: url)
        case .settingsAppearance:
            let settingsAppearance = settingsAppearance()
            return .push(settingsAppearance)
        case .settingsPassword:
            let settingsPassword = settingsPassword()
            return .push(settingsPassword)
        case .settingsAboutApp:
            let settingsAboutApp = settingsAboutApp()
            return .push(settingsAboutApp)
        }
    }

    func paywallCoordinator() -> PaywallCoordinator {
        let paywall = PaywallCoordinator(dependencies: dependencies, context: .settings)
        return paywall
    }

    func webView(_ url: URL, _ navigationTitle: String) -> UIViewController {
        return UIViewController()
    }
    
    private func settings() -> UIViewController {
        let settings = SettingsBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService,
            subscriptionService: dependencies.subscriptionService
        )
        return settings
    }
    
    private func settingsAppearance() -> UIViewController {
        let settingsAppearance = SettingsAppearanceBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService
        )
        return settingsAppearance
    }
    
    private func settingsPassword() -> UIViewController {
        let settingsPassword = SettingsPasswordBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService
        )
        return settingsPassword
    }
    
    private func settingsAboutApp() -> UIViewController {
        let settingsAboutApp = SettingsAboutAppBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService
        )
        return settingsAboutApp
    }
}
