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
    case settingsSearchEngine
    case settingsPassword
    case settingsAboutApp
    case settingsLanguages
    case settingsAppearance
    case telegram
    case email
    case paywall
    case privacyPolicy
    case termOfUse
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
        case .openSafari(let url):
            return .openSafari(url: url)
        case .settingsSearchEngine:
            let settingsSearchEngine = settingsSearchEngine()
            return .push(settingsSearchEngine)
        case .settingsPassword:
            let settingsPassword = settingsPassword()
            return .push(settingsPassword)
        case .settingsAboutApp:
            let settingsAboutApp = settingsAboutApp()
            return .push(settingsAboutApp)
        case .settingsLanguages:
            settingsLanguages()
            return .none()
        case .settingsAppearance:
            let settingsAppearance = settingsAppearance()
            return .push(settingsAppearance)
        case .telegram:
            let supportTelegram = AppConstants.supportTelegram
            guard let url = URL(string: supportTelegram)
            else { return .none() }
            return .openSafari(url: url)
        case .email:
            let supportMail = AppConstants.supportMail
            guard let url = URL(string: supportMail)
            else { return .none() }
            return .openSafari(url: url)
        case .privacyPolicy:
            guard let privacyPolicyUrl = URL(string: AppConstants.privacyPolicyURL)
            else { return .none() }
            return .openSafariInApp(url: privacyPolicyUrl, from: rootViewController)
        case .termOfUse:
            guard let termsOfUseURL = URL(string: AppConstants.termsOfUseURL)
            else { return .none() }
            return .openSafariInApp(url: termsOfUseURL, from: rootViewController)
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
    
    private func settingsSearchEngine() -> UIViewController {
        let settingsSearchEngine = SettingsSearchEngineBuilder.build(
            router: weakRouter,
            applicationState: dependencies.userDefaultState,
            analyticService: dependencies.analyticService
        )
        return settingsSearchEngine
    }
    
    private func settingsPassword() -> UIViewController {
        let settingsPassword = SettingsPasswordBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService
        )
        return settingsPassword
    }
    
    
    private func settingsAppearance() -> UIViewController {
        let settingsAppearance = SettingsAppearanceBuilder.build(
            router: weakRouter,
            applicationState: dependencies.userDefaultState,
            analyticService: dependencies.analyticService
        )
        return settingsAppearance
    }
    
    private func settingsAboutApp() -> UIViewController {
        let settingsAboutApp = SettingsAboutAppBuilder.build(
            router: weakRouter,
            analyticService: dependencies.analyticService
        )
        return settingsAboutApp
    }
    
    private func settingsLanguages() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
