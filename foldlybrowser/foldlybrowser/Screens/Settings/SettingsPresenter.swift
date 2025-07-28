//
//  SettingsPresenter.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import XCoordinator
import ApphudSDK
import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    func getData()
}

final class SettingsPresenter: SettingsPresenterProtocol {

    // MARK: - Dependencies
    private weak var view: SettingsViewControllerProtocol?
    private let router: WeakRouter<SettingsRoute>
    private let analyticService: CompositionalAnalyticService
    private let subscriptionService: SubscriptionService

    // MARK: - Init
    init(
        view: SettingsViewControllerProtocol,
        router: WeakRouter<SettingsRoute>,
        analyticService: CompositionalAnalyticService,
        subscriptionService: SubscriptionService
    ) {
        self.view = view
        self.router = router
        self.analyticService = analyticService
        self.subscriptionService = subscriptionService
    }

    // MARK: - Public
    @MainActor
    func getData() {
        let sections: [SettingsProps.Section] = [
            makeAuthProSection(),
            makeAppSection(),
            makeFeedbackSection()
        ]
        view?.render(SettingsProps(sections: sections))
    }
}

// MARK: - Private: Sections factory
private extension SettingsPresenter {

    func makeAuthProSection() -> SettingsProps.Section {
        .init(
            sectionTitle: "",
            sectionDesctiption: "",
            items: [
                .settingCell(makeCell(
                    title: "settings.authenticatorPro",
                    icon: "crown.fill",
                    color: UIColor.red,
                    action: authProSectionTapped)
                )
            ]
        )
    }

    func makeAppSection() -> SettingsProps.Section {
        .init(
            sectionTitle: .init(localized: "settings.app.section.title"),
            sectionDesctiption: .init(localized: "settings.app.section.description"),
            items: [
                .settingCell(makeCell(
                    title: "settings.appearance",
                    icon: "heart.fill",
                    color: UIColor.systemRed,
                    action: appearanceTapped)
                ),
                .settingCell(makeCell(
                    title: "settings.sounds",
                    icon: "square.and.arrow.up.fill",
                    color: UIColor.systemBlue,
                    action: soundsTapped)
                ),
                .settingCell(makeCell(
                    title: "settings.authorization",
                    icon: "envelope.fill",
                    color: UIColor.systemGreen,
                    action: authorizationTapped)
                ),
                .settingCell(makeCell(
                    title: "settings.languages",
                    icon: "applescript.fill",
                    color: UIColor.brown,
                    action: languagesTapped)
                )
            ]
        )
    }

    func makeFeedbackSection() -> SettingsProps.Section {
        .init(
            sectionTitle: .init(localized: "settings.feedback.section.title"),
            sectionDesctiption: .init(localized: "settings.feedback.section.description"),
            items: [
                .settingCell(makeCell(
                    title: "settings.contactUs",
                    icon: "heart.fill",
                    color: UIColor.systemRed,
                    action: contactUsTapped)
                ),
                .settingCell(makeCell(
                    title: "settings.contactUs",
                    icon: "square.and.arrow.up.fill",
                    color: UIColor.systemBlue,
                    action: contactUsTapped)
                ),
                .settingCell(makeCell(
                    title: "settings.aboutApp",
                    icon: "envelope.fill",
                    color: UIColor.systemGreen,
                    action: aboutAppTapped)
                )
            ]
        )
    }

    func makeCell(title: LocalizedStringResource, icon: String, color: UIColor, action: @escaping () -> Void) -> SettingsProps.SettingCell {
        return SettingsProps.SettingCell(
            text: .init(localized: title),
            icon: icon,
            iconBackgroundColor: color,
            select: action
        )
    }
}

// MARK: - Actions
private extension SettingsPresenter {
    func authProSectionTapped() {
        
    }
    
    func appearanceTapped() {
        router.trigger(.settingsAppearance)
    }
    
    func soundsTapped() {
        
    }
    
    func authorizationTapped() {
        router.trigger(.settingsPassword)
    }
    
    func languagesTapped() {
        
    }
    
    func contactUsTapped() {
        
    }
    
    func aboutAppTapped() {
        router.trigger(.settingsAboutApp)
    }
}
