//
//  SettingsAppearanceProps.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

struct SettingsAppearanceProps {
    var sections: [Section]

    struct Section {
        let sectionTitle: String
        let sectionDesctiption: String
        let items: [Items]
    }

    enum Items {
        case appearance(SettingAppearanceCell)
        case color(SettingColorCell)
    }

    struct SettingAppearanceCell {
        let text: String
        let select: () -> Void
    }
    
    struct SettingColorCell {
        let text: String
        let color: UIColor
        let isSelected: Bool
        let select: () -> Void
    }
}
