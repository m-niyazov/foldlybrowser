// 
//  HomeViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func render(_ props: HomeProps)
}

final class HomeViewController: KeyboardHandlingViewController, HomeViewControllerProtocol {
    
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: HomePresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: - Views
    var homeView = HomeView()
    let bottomSearchBar = HomeBottomSearchBar()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        setupView()
        addViews()
        setupConstraints()
        hideTabBar()
    }

    func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Methods
    func render(_ props: HomeProps) {
        homeView.render(props)
    }

    func update(_ props: HomeProps) {
        homeView.update(props)
    }

    func keyboardWillShow(keyboardHeight: CGFloat) {
        bottomSearchBar.makeSearchBarActive(keyboardHeight: keyboardHeight)
    }

    func keyboardWillHide() {
        bottomSearchBar.makeSearchBarInActive()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        keyboardHandlingRootView = view
    }
    
    func addViews() {
        view.addSubview(homeView)
        view.addSubview(bottomSearchBar)
    }
    
    func setupConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSearchBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UI Actions

}
