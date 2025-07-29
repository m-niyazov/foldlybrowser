//
// SettingsAboutAppProps.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

typealias SettingsAboutAppLinkCell = SettingsProps.SettingCell

struct SettingsAboutAppProps {
    var sections: [Section]

    struct Section {
        let sectionTitle: String
        let sectionDesctiption: String
        let items: [Items]
    }

    enum Items {
        case version(VersionCell)
        case link(SettingsAboutAppLinkCell)
    }
    
    struct VersionCell {
        let title: String
        let version: String
    }
}
