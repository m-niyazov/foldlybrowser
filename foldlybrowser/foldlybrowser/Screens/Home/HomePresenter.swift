// 
//  HomePresenter.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import Foundation
import XCoordinator

protocol HomePresenterProtocol: AnyObject {
    func loadData()
}

final class HomePresenter: HomePresenterProtocol {
    
    // MARK: - Properties

    private weak var view: HomeViewControllerProtocol?
    private let router: WeakRouter<HomeRoute>

    // MARK: - Initialize

    init(view: HomeViewControllerProtocol, router: WeakRouter<HomeRoute>) {
        self.view = view
        self.router = router
    }

    func loadData() {
        view?.render(.init(sections: [
            .init(type: .header(.init(tappedAppSettingsButton: nil))),
            .init(type: .searchTrends),
            .init(type: .sectionTitle(.init(
                title: "Favorites",
                subtitle: "Make a folder or add a site you like",
                buttontype: .seeAllFavorites,
                select: nil)
            )),
            .init(type: .folders([
                .init(id: "1", name: "Read Later", emoji: "📚"),
                .init(id: "2", name: "Spanish Learn", emoji: "🇪🇸"),
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
            )
        ]))
    }
}

// MARK: - Private Methods

private extension HomePresenter {
}
