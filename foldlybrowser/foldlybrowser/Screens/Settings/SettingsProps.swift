//
//  SettingsProps.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

struct SettingsProps {
    var sections: [Section]

    struct Section {
        let sectionTitle: String
        let sectionDesctiption: String
        let items: [Items]
    }

    enum Items {
        case settingCell(SettingCell)
    }

    struct SettingCell {
        let text: String
        let icon: String
        let iconBackgroundColor: UIColor
        let select: () -> Void
    }

    struct Banner {
        let title: String
        let subtitle: String
        let select: () -> Void
    }
}
