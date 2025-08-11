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
    var searchEngine: SearchEngine { get set }
    func getData()
}

final class SettingsSearchEnginePresenter: SettingsSearchEnginePresenterProtocol {
    var searchEngine: SearchEngine {
        get { applicationState.selectedSearchEngine }
        set { applicationState.selectedSearchEngine = newValue }
    }

    // MARK: - Dependencies
    private weak var view: SettingsSearchEngineViewControllerProtocol?
    private let router: WeakRouter<SettingsRoute>
    private var applicationState: UserDefaultsState
    private let analyticService: CompositionalAnalyticService

    // MARK: - Init
    init(
        view: SettingsSearchEngineViewControllerProtocol,
        router: WeakRouter<SettingsRoute>,
        applicationState: UserDefaultsState,
        analyticService: CompositionalAnalyticService
    ) {
        self.view = view
        self.router = router
        self.applicationState = applicationState
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
        let currentEngine = applicationState.selectedSearchEngine
        
        return .init(
            sectionTitle: .init(localized: "settings.searchEngine.engine.section.title"),
            sectionDesctiption: .init(localized: "settings.searchEngine.engine.section.description"),
            items: [
                .searchEngine(makeColorCell(
                    searchEngine: .google,
                    isSelected: currentEngine == .google,
                    color: UIColor.systemBlue)
                ),
                .searchEngine(makeColorCell(
                    searchEngine: .bing,
                    isSelected: currentEngine == .bing,
                    color: UIColor.systemGreen)
                ),
                .searchEngine(makeColorCell(
                    searchEngine: .duckduckgo,
                    isSelected: currentEngine == .duckduckgo,
                    color: UIColor.systemOrange)
                ),
                .searchEngine(makeColorCell(
                    searchEngine: .yandex,
                    isSelected: currentEngine == .yandex,
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
    
    func makeColorCell(searchEngine: SearchEngine, isSelected: Bool, color: UIColor) -> SettingsSearchEngineProps.SettingSearchEngineCell {
        return SettingsSearchEngineProps.SettingSearchEngineCell(
            searchEngine: searchEngine,
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
