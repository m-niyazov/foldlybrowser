//
//  SectionBackgroundView.swift
//  foldlybrowser
//
//  Created by TapticGroup on 22/06/2025.
//

import Foundation
import UIKit

final class HomeSectionBackgroundView: UICollectionReusableView {
    static let kind = "section-background"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white    // нужный цвет
        layer.cornerRadius = 22.5          // опция
    }

    required init?(coder: NSCoder) { fatalError() }
}
