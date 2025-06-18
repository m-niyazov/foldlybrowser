//
//  SettingsCoordinator.swift
//  absurdino
//
//  Created by Niyazov on 21.02.2023.
//

import UIKit
import XCoordinator

enum SettingsRoute: Route {
    case settings
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
         //   let settings = settings()
        //    return .set([settings])
            return .none()
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
         //   let webView = webView(urlLink, navigationTitle)
            // return .present(webView)
            return .none()
        case .openSafari(let url):
            return .openSafari(url: url)
        }
    }

//    func settings() -> UIViewController {
//        let settings = SettingsBuilder.build(
//            router: weakRouter,
//            applicationState: dependencies.applicationState,
//            analyticService: dependencies.analyticService,
//            subscriptionService: dependencies.subscriptionService
//        )
//        return settings
//    }

    func paywallCoordinator() -> PaywallCoordinator {
        let paywall = PaywallCoordinator(dependencies: dependencies, context: .settings)
        return paywall
    }

//    func webView(_ url: URL, _ navigationTitle: String) -> UIViewController {
//        let webView = WebViewBuilder.build(url, navigationTitle)
//        return UINavigationController(rootViewController: webView)
//    }
}
