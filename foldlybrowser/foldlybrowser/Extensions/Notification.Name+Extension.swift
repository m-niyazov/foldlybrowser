//
//  Notification.Name+Extension.swift
//  foldlybrowser
//
//  Created by Niyazov on 22.04.2023.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static var subscribedFromSettings: NSNotification.Name {
        NSNotification.Name(rawValue: "subscribedFromSettings")
    }

    static var didTapMoveBackPage: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapMoveBackPage")
    }

    static var didTapMoveForwardPage: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapMoveForwardPage")
    }

    static var webpageDidUpdateProgress: NSNotification.Name {
        NSNotification.Name(rawValue: "webpageDidUpdateProgress")
    }
}
