//
//  Animation+Fade.swift
//  foldlybrowser
//
//  Created by Niyazov on 20.11.2022.
//

import UIKit
import XCoordinator

extension Animation {
    static let fade = Animation(
        presentation: InteractiveTransitionAnimation.fade,
        dismissal: InteractiveTransitionAnimation.fade
    )
}

private extension InteractiveTransitionAnimation {
    static let fade = InteractiveTransitionAnimation(duration: 0.3) { transitionContext in
        guard let toView = transitionContext.viewController(forKey: .to),
              let fromView = transitionContext.viewController(forKey: .from) else { return }

        let container = transitionContext.containerView
        container.addSubview(toView.view)
        container.addSubview(fromView.view)

        toView.view.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve) {
            toView.view.alpha = 1
            fromView.view.alpha = 0
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
