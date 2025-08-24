// 
//  WebpageSavingViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import UIKit

protocol WebpageSavingViewControllerProtocol: AnyObject {
}

final class WebpageSavingViewController: UIViewController, WebpageSavingViewControllerProtocol {
    
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: WebpageSavingPresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: - Views

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupConstraints()
    }
    
    // MARK: - Methods

}

// MARK: - Private Methods

private extension WebpageSavingViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Save"
    }
    
    func addViews() {
    }
    
    func setupConstraints() {
    }
    
    // MARK: - UI Actions

}
