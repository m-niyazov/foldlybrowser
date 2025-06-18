//
//  File.swift
//  
//
//  Created by m.niyazov on 2/6/23.
//

import UIKit

extension UIFont {
    static func rounded(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: fontSize)
        } else {
            return .systemFont(ofSize: fontSize, weight: weight)
        }
    }
}
