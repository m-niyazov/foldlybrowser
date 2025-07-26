//
//  SettingsAppearancePresenter.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import XCoordinator
import ApphudSDK
import UIKit

protocol SettingsAppearancePresenterProtocol: AnyObject {
    var userSelectedColor: UIColor? { get set }
    func getData()
}

final class SettingsAppearancePresenter: SettingsAppearancePresenterProtocol {
    var userSelectedColor: UIColor? = .red
    

    // MARK: - Dependencies
    private weak var view: SettingsAppearanceViewControllerProtocol?
    private let router: WeakRouter<SettingsRoute>
    private let analyticService: CompositionalAnalyticService

    // MARK: - Init
    init(
        view: SettingsAppearanceViewControllerProtocol,
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
        let sections: [SettingsAppearanceProps.Section] = [
            makeThemeSection(),
            makeColorSection()
        ]
        view?.render(SettingsAppearanceProps(sections: sections))
    }
}

// MARK: - Private: Sections factory
private extension SettingsAppearancePresenter {

    func makeThemeSection() -> SettingsAppearanceProps.Section {
        .init(
            sectionTitle: .init(localized: "settings.appearance.theme.section.title"),
            sectionDesctiption: .init(localized: "settings.appearance.theme.section.description"),
            items: [
                .appearance(makeAppearanceCell(
                    title: "settings.appearance.automatic",
                    action: themeSwithced)
                )
            ]
        )
    }

    func makeColorSection() -> SettingsAppearanceProps.Section {
        .init(
            sectionTitle: .init(localized: "settings.appearance.colors.section.title"),
            sectionDesctiption: .init(localized: "settings.appearance.colors.section.description"),
            items: [
                .color(makeColorCell(
                    title: "colors.red",
                    isSelected: true,
                    color: UIColor.red,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.pink",
                    isSelected: false,
                    color: UIColor.pink,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.orange",
                    isSelected: false,
                    color: UIColor.orange,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.yellow",
                    isSelected: false,
                    color: UIColor.yellow,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.green",
                    isSelected: false,
                    color: UIColor.green,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.blue",
                    isSelected: false,
                    color: UIColor.blue,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.purple",
                    isSelected: false,
                    color: UIColor.purple,
                    action: colorSelected)
                ),
                .color(makeColorCell(
                    title: "colors.gray",
                    isSelected: false,
                    color: UIColor.gray,
                    action: colorSelected)
                )
            ]
        )
    }

    func makeAppearanceCell(title: LocalizedStringResource, action: @escaping () -> Void) -> SettingsAppearanceProps.SettingAppearanceCell {
        return SettingsAppearanceProps.SettingAppearanceCell(
            text: .init(localized: title),
            select: action
        )
    }
    
    func makeColorCell(title: LocalizedStringResource, isSelected: Bool, color: UIColor, action: @escaping () -> Void) -> SettingsAppearanceProps.SettingColorCell {
        return SettingsAppearanceProps.SettingColorCell(
            text: .init(localized: title),
            color: color,
            isSelected: isSelected,
            select: action
        )
    }
}

// MARK: - Actions
private extension SettingsAppearancePresenter {
    func themeSwithced() {
        
    }
    
    func colorSelected() {
        
    }
}
