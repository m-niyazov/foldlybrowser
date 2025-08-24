// 
//  WebpageSavingPresenter.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import Foundation
import XCoordinator

protocol WebpageSavingPresenterProtocol: AnyObject {
}

final class WebpageSavingPresenter: WebpageSavingPresenterProtocol {
    
    // MARK: - Properties

    private weak var view: WebpageSavingViewControllerProtocol?
    private let router: WeakRouter<HomeRoute>
    private let url: URL
    private let userDefaultState: UserDefaultsState

    // MARK: - Initialize

    init(view: WebpageSavingViewControllerProtocol,
         router: WeakRouter<HomeRoute>,
         url: URL,
         userDefaultState: UserDefaultsState) {
        self.view = view
        self.router = router
        self.url = url
        self.userDefaultState = userDefaultState
    }
}

// MARK: - Private Methods

private extension WebpageSavingPresenter {
}
