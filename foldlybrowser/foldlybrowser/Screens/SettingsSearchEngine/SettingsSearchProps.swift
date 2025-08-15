//
//  SettingsSearchEngineProps.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

struct SettingsSearchEngineProps {
    var sections: [Section]

    struct Section {
        let sectionTitle: String
        let sectionDesctiption: String
        var items: [Items]
    }

    enum Items {
        case automatic(SettingSwitcherCell)
        case searchEngine(SettingSearchEngineCell)
    }

    struct SettingSwitcherCell {
        let text: String
        var switcherValue: Bool
    }
    
    struct SettingSearchEngineCell {
        let searchEngine: SearchEngine
        let color: UIColor
        let isSelected: Bool
    }
}
