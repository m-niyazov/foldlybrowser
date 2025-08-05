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
        let items: [Items]
    }

    enum Items {
        case automatic(SettingSwitcherCell)
        case searchEngine(SettingSearchEngineCell)
    }

    struct SettingSwitcherCell {
        let text: String
        let switched: () -> Void
    }
    
    struct SettingSearchEngineCell {
        let type: SearchEngineType
        let color: UIColor
        let isSelected: Bool
    }
}


enum SearchEngineType: String {
    case google
    case bing
    case duckDuckGo
    case yandex
    
    var name : String {
        switch self {
        case .google:
            return "Google"
        case .bing:
            return "Bing"
        case .duckDuckGo:
            return "Duck Duck Go"
        case .yandex:
            return "Yandex"
        }
    }
}

