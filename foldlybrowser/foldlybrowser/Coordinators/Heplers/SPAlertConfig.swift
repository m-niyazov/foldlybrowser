//
//  SPAlert.swift
//  foldlybrowser
//
//  Created by Niyazov on 12.06.2023.
//

import UIKit
import SPAlert

struct SPAlertConfig {
    let alertView: SPAlertView
    var haptic: SPAlertHaptic = .none
    var duration: TimeInterval = 4
    var spaceBetweenIconAndTitle: CGFloat?
    var iconColor: UIColor = UIColor.white
    var titleColor: UIColor = UIColor.secondaryLabel
    var subtitleColor: UIColor = UIColor.secondaryLabel
    var completion: (() -> Void)?
}
