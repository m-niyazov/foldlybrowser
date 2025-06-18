//
//  Notification.Name+Extension.swift
//  absurdino
//
//  Created by Niyazov on 22.04.2023.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static var subscribedFromSettings: NSNotification.Name {
        NSNotification.Name(rawValue: "subscribedFromSettings")
    }
    static var createdNewCharacter: NSNotification.Name {
        NSNotification.Name(rawValue: "createdNewCharacter")
    }

    static var buyedFromMain: NSNotification.Name {
        NSNotification.Name(rawValue: "buyedFromMain")
    }
}
