// 
//  WebpageSavingPresenter.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import Foundation
import FaviconFinder
import XCoordinator
import UIKit

protocol WebpageSavingPresenterProtocol: AnyObject {
    func getData()
}

final class WebpageSavingPresenter: WebpageSavingPresenterProtocol {
    
    // MARK: - Properties

    private weak var view: WebpageSavingViewControllerProtocol?
    private let router: WeakRouter<HomeRoute>
    private let webPageUrl: URL
    private let webPageTitle: String
    private let userDefaultState: UserDefaultsState

    // MARK: - Initialize

    init(view: WebpageSavingViewControllerProtocol,
         router: WeakRouter<HomeRoute>,
         webPageUrl: URL,
         webPageTitle: String,
         userDefaultState: UserDefaultsState) {
        self.view = view
        self.router = router
        self.webPageUrl = webPageUrl
        self.webPageTitle = webPageTitle
        self.userDefaultState = userDefaultState
    }

    func getData() {
        view?.render(url: webPageUrl.absoluteString, title: webPageTitle)
        Task {
            if let icon = await FaviconFetcher.fetchIcon(for: webPageUrl) {
                self.view?.setFavicon(image: icon)
            }
        }

//        let favicon = try await FaviconFinder(url: webPageUrl)
//            .fetchFaviconURLs()
//            .download()
//            .largest()
//
//        let faviconImage = favicon.image as? UIImage
//        print("EFWEF\(faviconImage)")
//        view?.setFavicon(image: (favicon.image as? UIIM))
    }
}

// MARK: - Private Methods

private extension WebpageSavingPresenter {
}
