//
//  Transition.swift
//  absurdino
//
//  Created by Niyazov on 20.11.2022.
//

import StoreKit
import SPAlert
import XCoordinator

extension Transition {
    static func openSafari(url: URL?) -> Transition {
        guard let url = url else {
            return .none()
        }
        UIApplication.shared.open(url)
        return .none()
    }

    static func appSettings() -> Transition {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return .none()
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
        return .none()
    }

    static func presentAlert(_ alert: Alert) -> Transition {
        let actions = alert.actions.map { alert in
            UIAlertAction(
                title: alert.title,
                style: alert.style
            ) { _ in alert.action?() }
        }
        let alert = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: alert.style
        )
        actions.forEach { alert.addAction($0) }
        return .present(alert)
    }

    static func presentSPAlert(_ alert: SPAlertConfig) -> Transition {
        let alertView = alert.alertView
        alertView.duration = TimeInterval(alert.duration)
        alertView.iconView?.tintColor = alert.iconColor
        alertView.titleLabel?.textColor = alert.titleColor
        alertView.subtitleLabel?.textColor = alert.subtitleColor
        if let iconAndTitleSpace = alert.spaceBetweenIconAndTitle {
            alertView.layout.spaceBetweenIconAndTitle = iconAndTitleSpace
        }
        alertView.present(haptic: alert.haptic, completion: alert.completion)
        return .none()
    }

    static func appReview() -> Transition {
        if let scene = UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
        return .none()
    }

    static func presentFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
        presentable.viewController?.modalPresentationStyle = .fullScreen
        return .present(presentable, animation: animation)
    }
}
