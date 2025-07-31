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
        print("deioinfdie")
    }

    // MARK: - Methods

    func render(url: URL) {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

// MARK: - Private Methods

private extension WebpageViewController {
    
    func setupView() {
    }
    
    func addViews() {
    }
    
    func setupConstraints() {
    }
    
    // MARK: - UI Actions

}


extension WebpageViewController: WKNavigationDelegate {
}
