//
//  SettingsAboutAppPresenter.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import XCoordinator
import ApphudSDK
import UIKit

typealias SettingLinkCell = SettingsProps.SettingCell

protocol SettingsAboutAppPresenterProtocol: AnyObject {
    var userSelectedColor: UIColor? { get set }
    func getData()
}

final class SettingsAboutAppPresenter: SettingsAboutAppPresenterProtocol {
    var userSelectedColor: UIColor? = .red

    // MARK: - Dependencies
    private weak var view: SettingsAboutAppViewControllerProtocol?
    private let router: WeakRouter<SettingsRoute>
    private let analyticService: CompositionalAnalyticService

    // MARK: - Init
    init(
        view: SettingsAboutAppViewControllerProtocol,
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
        let sections: [SettingsAboutAppProps.Section] = makeSections()
        view?.render(SettingsAboutAppProps(sections: sections))
    }
}

// MARK: - Private: Sections factory
private extension SettingsAboutAppPresenter {
    func makeSections() -> [SettingsAboutAppProps.Section] {
        [.init(
            sectionTitle: .init(localized: "settings.aboutApp.version.section.title"),
            sectionDesctiption: .init(localized: "settings.aboutApp.protection.section.description"),
            items: [
                .version(makeVersionCell(
                    title: "settings.aboutApp.current",
                    version: AppConstants.currentVersion)
                )
            ]
        ),
            .init(
                sectionTitle: "",
                sectionDesctiption: .init(localized: ""),
                items: [
                    .link(makeLinkCell(
                        title: "settings.privacyPolicy",
                        action: openPrivacyPolicy)
                    ),
                    .link(makeLinkCell(
                        title: "settings.termOfUse",
                        action: openTermOfUse)
                    )
                ]
            )
         ]
    }

    func makeVersionCell(title: LocalizedStringResource, version: String) -> SettingsAboutAppProps.VersionCell {
        return SettingsAboutAppProps.VersionCell(
            title: .init(localized: title),
            version: version
        )
    }
    
    func makeLinkCell(title: LocalizedStringResource, action: @escaping () -> Void) -> SettingLinkCell {
        return SettingLinkCell(
            text: .init(localized: title),
            icon: "",
            iconBackgroundColor: .clear,
            select: action
        )
    }
}

// MARK: - Actions
private extension SettingsAboutAppPresenter {
    func openPrivacyPolicy() {
        router.trigger(.privacyPolicy)
    }
    
    func openTermOfUse() {
        router.trigger(.termOfUse)
    }
}
