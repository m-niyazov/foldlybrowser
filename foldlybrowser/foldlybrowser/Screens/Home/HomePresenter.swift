// 
//  HomePresenter.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import Foundation
import XCoordinator
import UIKit

protocol HomePresenterProtocol: AnyObject {
    func loadData()
}

final class HomePresenter: HomePresenterProtocol {
    
    // MARK: - Properties

    private weak var view: HomeViewControllerProtocol?
    private let router: WeakRouter<HomeRoute>
    private var props: HomeProps?

    // MARK: - Initialize

    init(view: HomeViewControllerProtocol, router: WeakRouter<HomeRoute>) {
        self.view = view
        self.router = router
    }

    func loadData() {
        let props: HomeProps = .init(
            sections: [
                .init(type: .header(.init(tappedAppSettingsButton: didTapSettings))),
                .init(type: .searchTrends),
                .init(type: .sectionTitle(.init(
                    title: "Favorites",
                    subtitle: "Make a folder or add a site you like",
                    buttontype: .seeAllFavorites,
                    select: nil)
                )),
                .init(type: .mainTappableItems([
                    .folder(.init(id: "f1", name: "Read Later", emoji: "📚")),
                    .website(.init(id: "s1", name: "Apple", thumbnailURL: "", folderId: nil)),
                    .addNew
                    //                .init(id: "3", name: "Work", emoji: "💼"),
                    //                .init(id: "4", name: "Movies", emoji: "🎥"),
                    //                .init(id: "5", name: "18+", emoji: "🔞"),
                    //                .init(id: "6", name: "Personal", emoji: "👮🏻‍♂️"),
                ])),
                .init(type: .sectionTitle(.init(
                    title: "Imported",
                    subtitle: "Shared packs you’ve added",
                    buttontype: .importFolder,
                    select: nil))
                     )],
            bottomSearchBar: .init(
                didTapSearch: didTapSearch,
                didTapHome: didTapHome,
                didTapMoveBackPage: didTapMoveBackPage,
                didTapMoveForwardPage: didTapMoveForwardPage,
                didTapSavePage: didTapSavePage
            ),
            isNeedToShowWebPage: false,
            removeAndDismissWebPage: { [weak self] in
                self?.router.trigger(.dismissWebpage)
            }
        )
        self.props = props
        view?.render(props)
    }

    func didTapSearch(_ searchingText: String) {
        self.props?.isNeedToShowWebPage = true
        updateViewProps()
        router.trigger(.webpage(requestString: searchingText))
    }

    func didTapMoveBackPage() {

    }

    func didTapMoveForwardPage() {

    }

    func didTapSavePage() {

    }

    func didTapHome() {
        self.props?.isNeedToShowWebPage = false
        updateViewProps()
    }

    func updateViewProps() {
        if let props = props {
            view?.update(props)
        }
    }
}

// MARK: - Private Methods

private extension HomePresenter {
    func didTapSettings() {
        router.trigger(.settings)
    }
}
