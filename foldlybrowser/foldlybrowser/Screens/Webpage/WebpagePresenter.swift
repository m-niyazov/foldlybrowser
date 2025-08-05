//
//  WebpagePresenter.swift
//  foldlybrowser
//
//  Created by TapticGroup on 12/07/2025.
//

import Foundation
import XCoordinator

protocol WebpageLogicDelegate: AnyObject {
    func webpageDidStartLoading()
    func webpageDidFinishLoading()
    func webpageDidGoBackEnabled(_ enabled: Bool)
    func webpageDidGoForwardEnabled(_ enabled: Bool)
}

protocol WebpagePresenterProtocol: AnyObject {
    func loadData()
}

final class WebpagePresenter: WebpagePresenterProtocol {

    // MARK: - Properties

    private weak var view: WebpageViewControllerProtocol?
    weak var delegate: WebpageLogicDelegate?
    private let router: WeakRouter<HomeRoute>
    private let userDefaultState: UserDefaultsState
    private let requestString: String

    // MARK: - Initialize

    init(view: WebpageViewControllerProtocol,
         router: WeakRouter<HomeRoute>,
         requestString: String,
         userDefaultState: UserDefaultsState) {
        self.view = view
        self.router = router
        self.requestString = requestString
        self.userDefaultState = userDefaultState
        setupObservers()
    }

    deinit {
        removeObservers()
    }

    func loadData() {
        let urlToLoad = SearchURLBuilder.buildURL(
            from: requestString,
            using: userDefaultState.selectedSearchEngine
        )
        view?.render(url: urlToLoad)

    }
}

// MARK: - Private Methods

private extension WebpagePresenter {
    func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapMoveBackPage),
            name: .didTapMoveBackPage,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapMoveForwardPage),
            name: .didTapMoveForwardPage,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapMoveRefreshPage),
            name: .didTapMoveRefreshPage,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapSearchWhileWebviewActive(_:)),
            name: .didTapSearchWhileWebviewActive,
            object: nil
        )
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func didTapMoveBackPage() {
        view?.webView.goBack()
    }

    @objc func didTapMoveForwardPage() {
        view?.webView.goForward()
    }

    @objc func didTapMoveRefreshPage() {
        view?.webView.reload()
    }

    @objc func didTapSearchWhileWebviewActive(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let searchingText = userInfo["searchingText"] as? String else { return }
        let urlToLoad = SearchURLBuilder.buildURL(
            from: searchingText,
            using: userDefaultState.selectedSearchEngine
        )
        view?.render(url: urlToLoad)
    }
}
