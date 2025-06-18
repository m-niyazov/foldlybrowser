//
//  Float+Extension.swift
//  tralala-creator
//
//  Created by TapticGroup on 27.03.2025.
//

import Foundation

extension Float {
    func decimalize() -> Float {
         return Float(floor(self * 100) / 100)
    }
}

extension Double {
    func decimalize() -> Double {
        return floor(self * 100) / 100
    }
}
