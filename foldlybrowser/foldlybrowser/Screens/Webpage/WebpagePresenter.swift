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
    private let requestString: String

    // MARK: - Initialize

    init(view: WebpageViewControllerProtocol,
         router: WeakRouter<HomeRoute>,
         requestString: String) {
        self.view = view
        self.router = router
        self.requestString = requestString
    }

    func loadData() {
        view?.render(url: .init(string: "https://www.google.com/search?q=\(requestString)")!)
    }
}

// MARK: - Private Methods

private extension WebpagePresenter {
}
