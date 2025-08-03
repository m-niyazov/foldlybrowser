//
//  WebpageViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 12/07/2025.
//

import UIKit
import WebKit

protocol WebpageOutputlegate: AnyObject {
    func webpageDidStartLoading()
    func webpageDidFinishLoading()
}

protocol WebpageInputDelegateDelegate: AnyObject {
    func webpageDidStartLoading()
    func webpageDidFinishLoading()
}

protocol WebpageViewControllerProtocol: AnyObject {
    var webView: WKWebView! { get }
    func render(url: URL)
}

final class WebpageViewController: UIViewController, WebpageViewControllerProtocol {
    
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: WebpagePresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: - Views
    var webView: WKWebView!
    private let scrollThreshold: CGFloat = 50
    private var lastNotifiedOffsetY: CGFloat = 0

    // MARK: - Lifecycle

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        setupView()
        addViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "estimatedProgress" {
            let progress = webView.estimatedProgress
            NotificationCenter.default.post(
                name: .webpageDidUpdateProgress,
                object: nil,
                userInfo: ["progress": progress]
            )
        }
    }
    
    // MARK: - Methods

    func render(url: URL) {
        webView.load(URLRequest(url: url))
    }
}

// MARK: - Private Methods

private extension WebpageViewController {
    
    func setupView() {
        webView.do {
            $0.allowsBackForwardNavigationGestures = true
            $0.scrollView.delegate = self
            lastNotifiedOffsetY = webView.scrollView.contentOffset.y
            $0.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
    }
    
    func addViews() {
    }
    
    func setupConstraints() {
    }
    
    // MARK: - UI Actions

}


extension WebpageViewController: WKNavigationDelegate, UIScrollViewDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NotificationCenter.default.post(
            name: .webpageDidUpdateProgress,
            object: nil,
            userInfo: ["progress": 1.0]
        )

        NotificationCenter.default.post(
            name: .webpageDidUpdateURL,
            object: nil,
            userInfo: ["url": webView.url?.absoluteString ?? ""]
        )
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NotificationCenter.default.post(
            name: .webpageDidUpdateURL,
            object: nil,
            userInfo: ["url": webView.url?.absoluteString ?? ""]
        )
        postScrollNotification(hideBottomBar: false)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Вычисляем границы «бесконечного» скролла:
        let topBounceLimit = -scrollView.adjustedContentInset.top
        let bottomBounceLimit = scrollView.contentSize.height + scrollView.adjustedContentInset.bottom - scrollView.bounds.height

        // Если мы в зоне bounce (притянули дальше верхней или нижней границы) — не шлём уведомление
        let y = scrollView.contentOffset.y
        guard y >= topBounceLimit, y <= bottomBounceLimit else {
            return
        }

        // Теперь остальная ваша логика с порогом
        let adjustedY = y + scrollView.adjustedContentInset.top
        let delta = adjustedY - lastNotifiedOffsetY

        if delta > scrollThreshold {
            postScrollNotification(hideBottomBar: true)
            lastNotifiedOffsetY = adjustedY
        }
        else if delta < -scrollThreshold {
            postScrollNotification(hideBottomBar: false)
            lastNotifiedOffsetY = adjustedY
        }
    }

    private func postScrollNotification(hideBottomBar: Bool) {
        NotificationCenter.default.post(
            name: .webViewDidScroll,
            object: nil,
            userInfo: ["isNeedToHide": hideBottomBar]
        )
    }
}
