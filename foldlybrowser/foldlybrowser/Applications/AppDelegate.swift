//
//  AppDelegate.swift
//  foldlybrowser
//
//  Created by TapticGroup on 15/06/2025.
//
import UIKit
import ApphudSDK
import AmplitudeSwift
import AdSupport
import AppsFlyerLib
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
//        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 40)
//        AppsFlyerLib.shared().appsFlyerDevKey = AppConstants.appsFlyerKey
//        AppsFlyerLib.shared().appleAppID = AppConstants.appID
//        // AppsFlyerLib.shared().isDebug = true
//        AppsFlyerLib.shared().isDebug = false
//        AppsFlyerLib.shared().delegate = self
//        Apphud.setDelegate(self)
//        Apphud.start(apiKey: AppConstants.appHudKey)
//        Amplitude.instance().defaultTracking.sessions = true
//        Amplitude.instance().initializeApiKey(AppConstants.amplitudeKey, userId: Apphud.userID())
//        Amplitude.instance().adSupportBlock = {
//            ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        }
//        // Facebok SDK Method
//        ApplicationDelegate.shared.application(
//            application,
//            didFinishLaunchingWithOptions: launchOptions
//        )
        return true
    }

    // Facebok SDK Method
//    func application(
//          _ app: UIApplication,
//          open url: URL,
//          options: [UIApplication.OpenURLOptionsKey: Any] = [:]
//      ) -> Bool {
//          ApplicationDelegate.shared.application(
//              app,
//              open: url,
//              sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//              annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//          )
//      }

    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        Apphud.setAttribution(
            data: .init(rawData: installData),
            from: .appsFlyer,
            identifer: AppsFlyerLib.shared().getAppsFlyerUID(),
            callback: { _ in }
        )
    }

    func onConversionDataFail(_ error: Error) {
        Apphud.setAttribution(
            data: .init(rawData: ["error": error.localizedDescription]),
            from: .appsFlyer,
            identifer: AppsFlyerLib.shared().getAppsFlyerUID(),
            callback: { _ in }
        )
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
}

extension AppDelegate: ApphudDelegate {
    func apphudDidChangeUserID(_ userID: String) {
//        Amplitude.instance().setUserId(userID)
    }
}
