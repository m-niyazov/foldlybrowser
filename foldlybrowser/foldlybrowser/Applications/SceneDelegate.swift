//
//  SceneDelegate.swift
//  foldlybrowser
//
//  Created by TapticGroup on 15/06/2025.
//

import AppTrackingTransparency
import AppsFlyerLib
import UIKit
// import FacebookCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        // Facebok SDK Method
//        if let userActivity = connectionOptions.userActivities.first,
//           userActivity.activityType == NSUserActivityTypeBrowsingWeb {
//            ApplicationDelegate.shared.application(.shared, continue: userActivity)
//            AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
//        } else if let url = connectionOptions.urlContexts.first?.url {
//            AppsFlyerLib.shared().handleOpen(url, options: nil)
//        }

        /// Compositional Root
        let dependencies = dependencies()
        rootCoordinator = AppCoordinator(dependencies: dependencies)

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        rootCoordinator?.setRoot(for: window)
    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        AppsFlyerLib.shared().start()
//    }
//
//    // Facebok SDK Method
//      func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
//          guard let url = URLContexts.first?.url else {
//              return
//          }
//
//          ApplicationDelegate.shared.application(
//              UIApplication.shared,
//              open: url,
//              sourceApplication: nil,
//              annotation: [UIApplication.OpenURLOptionsKey.annotation]
//          )
//      }
//
//    // Facebok SDK Method
//      func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
//          ApplicationDelegate.shared.application(.shared, continue: userActivity)
//      }
}
