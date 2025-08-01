//
//  SettingsSearchEnginePresenter.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import XCoordinator
import ApphudSDK
import UIKit

protocol SettingsSearchEnginePresenterProtocol: AnyObject {
    var searchEngine: SearchEngineType { get set }
    func getData()
}

final class SettingsSearchEnginePresenter: SettingsSearchEnginePresenterProtocol {
    var searchEngine: SearchEngineType = .google

    // MARK: - Dependencies
    private weak var view: SettingsSearchEngineViewControllerProtocol?
    private let router: WeakRouter<SettingsRoute>
    private let analyticService: CompositionalAnalyticService

    // MARK: - Init
    init(
        view: SettingsSearchEngineViewControllerProtocol,
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService
    ) {
        self.view = view
        self.router = router
        self.analyticService = analyticService
    }

    // MARK: - Public
    @MainActor
    func getData() {
        let sections: [SettingsSearchEngineProps.Section] = [
            makeAutomaticSection(),
            makeSearchEngineSection()
        ]
        view?.render(SettingsSearchEngineProps(sections: sections))
    }
}

// MARK: - Private: Sections factory
private extension SettingsSearchEnginePresenter {

    func makeAutomaticSection() -> SettingsSearchEngineProps.Section {
        .init(
            sectionTitle: .init(localized: "settings.searchEngine.automatic.section.title"),
            sectionDesctiption: .init(localized: "settings.searchEngine.automatic.section.description"),
            items: [
                .automatic(makeAppearanceCell(
                    title: "settings.searchEngine.automatic",
                    action: automaticSwithced)
                )
            ]
        )
    }

    func makeSearchEngineSection() -> SettingsSearchEngineProps.Section {
        .init(
            sectionTitle: .init(localized: "settings.searchEngine.engine.section.title"),
            sectionDesctiption: .init(localized: "settings.searchEngine.engine.section.description"),
            items: [
                .searchEngine(makeColorCell(
                    type: .google,
                    isSelected: true,
                    color: UIColor.systemBlue)
                ),
                .searchEngine(makeColorCell(
                    type: .bing,
                    isSelected: false,
                    color: UIColor.systemGreen)
                ),
                .searchEngine(makeColorCell(
                    type: .duckDuckGo,
                    isSelected: false,
                    color: UIColor.systemOrange)
                ),
                .searchEngine(makeColorCell(
                    type: .yandex,
                    isSelected: false,
                    color: UIColor.red)
                )
            ]
        )
    }

    func makeAppearanceCell(title: LocalizedStringResource, action: @escaping () -> Void) -> SettingsSearchEngineProps.SettingSwitcherCell {
        return SettingsSearchEngineProps.SettingSwitcherCell(
            text: .init(localized: title),
            switched: action
        )
    }
    
    func makeColorCell(type: SearchEngineType, isSelected: Bool, color: UIColor) -> SettingsSearchEngineProps.SettingSearchEngineCell {
        return SettingsSearchEngineProps.SettingSearchEngineCell(
            type: type,
            color: color,
            isSelected: isSelected
        )
    }
}

// MARK: - Actions
private extension SettingsSearchEnginePresenter {
    func automaticSwithced() {
        
    }
}
