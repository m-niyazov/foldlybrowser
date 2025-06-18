//
//  UIApplication+Extension.swift
//  tralala-creator
//
//  Created by TapticGroup on 27.03.2025.
//

import Foundation
import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}
