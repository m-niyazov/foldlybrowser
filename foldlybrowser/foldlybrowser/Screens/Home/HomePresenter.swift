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
            .init(type: .header(.init(tappedAppSettingsButton: nil)))
//            .init(type: .sectionTitle(.init(
//                title: "Favorites",
//                subtitle: "Make a folder or add a site you like",
//                buttontype: .seeAllFavorites,
//                select: nil))
//            ),
//            .init(type: .sectionTitle(.init(
//                title: "Imported",
//                subtitle: "Shared packs you’ve added",
//                buttontype: nil,
//                select: nil))
//            )
        ]))
    }
}

// MARK: - Private Methods

private extension HomePresenter {
}
