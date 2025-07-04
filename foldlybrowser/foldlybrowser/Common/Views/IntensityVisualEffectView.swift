//
//  sdcvdfvc.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit

final class IntensityVisualEffectView: UIVisualEffectView {
  /// Create visual effect view with given effect and its intensity
  ///
  /// - Parameters:
  ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
  ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
  init(effect: UIVisualEffect, intensity: CGFloat) {
    theEffect = effect
    customIntensity = intensity
    super.init(effect: nil)
  }

  required init?(coder aDecoder: NSCoder) { nil }

  deinit {
    animator?.stopAnimation(true)
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    effect = nil
    animator?.stopAnimation(true)
    animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
      self.effect = theEffect
    }
    animator?.fractionComplete = customIntensity
  }

  private let theEffect: UIVisualEffect
  private let customIntensity: CGFloat
  private var animator: UIViewPropertyAnimator?
}
