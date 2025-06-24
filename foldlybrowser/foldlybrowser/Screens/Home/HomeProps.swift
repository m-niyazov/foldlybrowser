//
//  HomeProps.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit

struct HomeProps {
    var sections: [Section]

    struct Section {
        var type: Cell
    }

    enum Cell: Equatable {
        static func == (lhs: HomeProps.Cell, rhs: HomeProps.Cell) -> Bool {
            true
        }
        case header(HeaderProps)
        case searchTrends
        case sectionTitle(SectionTitleProps)
        case mainTappableItems([MainTappableItem])
    }

    struct HeaderProps {
        let tappedAppSettingsButton: (() -> Void)?
    }

    struct SectionTitleProps {
        let title: String
        let subtitle: String?
        let buttontype: ButtonType?
        let select: ((_ type: ButtonType) -> Void)?

        enum ButtonType {
            case seeAllFavorites
            case importFolder
            case closeAds
        }
    }

    enum MainTappableItem {
        case folder(MainTappableItemFolder)
        case website(MainTappableItemWebsite)
        case addNew

        struct MainTappableItemFolder {
            let id: String
            let name: String
            let emoji: String?
        }

        struct MainTappableItemWebsite {
            let id: String
            let name: String
            let thumbnailURL: String
            let folderId: String?
        }
    }
}
