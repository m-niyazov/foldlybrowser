//
// SettingsPasswordProps.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

typealias SettingPropsPasswordCell = SettingsAppearanceProps.SettingAppearanceCell

struct SettingsPasswordProps {
    var sections: [Section]

    struct Section {
        let sectionTitle: String
        let sectionDesctiption: String
        let items: [Items]
    }

    enum Items {
        case settingPasswordCell(SettingPropsPasswordCell)
    }
}
