//
//  Notification.Name+Extension.swift
//  foldlybrowser
//
//  Created by Niyazov on 22.04.2023.
//

import Foundation
import UIKit

extension NSNotification.Name {

    static var didTapMoveBackPage: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapMoveBackPage")
    }

    static var didTapMoveForwardPage: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapMoveForwardPage")
    }

    static var didTapMoveRefreshPage: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapMoveRefreshdPage")
    }

    static var didTapSearchWhileWebviewActive: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapSearchWhileWebviewActive")
    }

    static var didTapSavePage: NSNotification.Name {
        NSNotification.Name(rawValue: "didTapSavePage")
    }

    static var webpageDidUpdateProgress: NSNotification.Name {
        NSNotification.Name(rawValue: "webpageDidUpdateProgress")
    }
    
    static var webpageDidUpdateURL: NSNotification.Name {
        NSNotification.Name(rawValue: "webpageDidUpdateURL")
    }

    static var webViewDidScroll: NSNotification.Name {
        NSNotification.Name(rawValue: "webViewDidScroll")
    }
    
    static var accentColorDidChange: NSNotification.Name {
        NSNotification.Name(rawValue: "accentColorDidChange")
    }
}
