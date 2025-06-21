//
//  KeyboardHandlingViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit

class KeyboardHandlingViewController: UIViewController {
    weak var keyboardHandlingRootView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
        initializeHideKeyboard()
    }
}

extension KeyboardHandlingViewController {
    private func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard)
        )
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissMyKeyboard() {
        view.endEditing(true)
    }
}

extension KeyboardHandlingViewController {
    private func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            (self as? HomeViewController)?.keyboardWillShow(keyboardHeight: keyboardHeight)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        (self as? HomeViewController)?.keyboardWillHide()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension KeyboardHandlingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let scroll = keyboardHandlingRootView else {
            return true
        }
        return touch.view?.isDescendant(of: scroll) ?? false
    }
}
