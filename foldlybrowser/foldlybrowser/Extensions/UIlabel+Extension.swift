//
//  UIlabel+Extension.swift
//  foldlybrowser
//
//  Created by TapticGroup on 31/03/2025.
//

import Foundation
import UIKit

extension UILabel {
    func setTyping(text: String, characterDelay: TimeInterval = 2.5, completion: (() -> Void)? = nil) {
        self.text = ""

        let writingTask = DispatchWorkItem { [weak self] in
            text.forEach { char in
                DispatchQueue.main.async {
                    self?.text?.append(char)
                }
                Thread.sleep(forTimeInterval: characterDelay / 100)
            }

            DispatchQueue.main.async {
                completion?()
            }
        }

        let queue: DispatchQueue = .init(label: "typespeed", qos: .userInteractive)
        queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }
}
