//
//  SettingsPasswordPresenter.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import XCoordinator
import ApphudSDK
import UIKit

protocol SettingsPasswordPresenterProtocol: AnyObject {
    var userSelectedColor: UIColor? { get set }
    func getData()
}

final class SettingsPasswordPresenter: SettingsPasswordPresenterProtocol {
    var userSelectedColor: UIColor? = .red
    

    // MARK: - Dependencies
    private weak var view: SettingsPasswordViewControllerProtocol?
    private let router: WeakRouter<SettingsRoute>
    private let analyticService: CompositionalAnalyticService

    // MARK: - Init
    init(
        view: SettingsPasswordViewControllerProtocol,
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
        let sections: [SettingsPasswordProps.Section] = makeSections()
        view?.render(SettingsPasswordProps(sections: sections))
    }
}

// MARK: - Private: Sections factory
private extension SettingsPasswordPresenter {
    func makeSections() -> [SettingsPasswordProps.Section] {
        [.init(
            sectionTitle: .init(localized: "settings.password.protection.section.title"),
            sectionDesctiption: .init(localized: "settings.password.protection.section.description"),
            items: [
                .settingPasswordCell(makePasswordCell(
                    title: "settings.password.authorization",
                    action: protectionSwithced)
                )
            ]
        ),
            .init(
                sectionTitle: "",
                sectionDesctiption: .init(localized: "settings.password.widgets.section.description"),
                items: [
                    .settingPasswordCell(makePasswordCell(
                        title: "settings.password.allowWidgets",
                        action: widgetsSwithced)
                    )
                ]
            )
         ]
    }

    func makePasswordCell(title: LocalizedStringResource, action: @escaping () -> Void) -> SettingPropsPasswordCell {
        return SettingPropsPasswordCell(
            text: .init(localized: title),
            select: action
        )
    }
}

// MARK: - Actions
private extension SettingsPasswordPresenter {
    func protectionSwithced() {
        
    }
    
    func widgetsSwithced() {
        
    }
}
