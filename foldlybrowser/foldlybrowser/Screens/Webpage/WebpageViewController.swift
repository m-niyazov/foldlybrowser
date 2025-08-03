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
            $0.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }
    }
    
    func addViews() {
    }
    
    func setupConstraints() {
    }
    
    // MARK: - UI Actions

}


extension WebpageViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NotificationCenter.default.post(
            name: .webpageDidUpdateProgress,
            object: nil,
            userInfo: ["progress": 1.0]
        )
    }
}
