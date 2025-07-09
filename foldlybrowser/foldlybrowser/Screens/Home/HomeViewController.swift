// 
//  HomeViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func render(_ props: HomeProps)
    func showChildViewControllerWithAnimation(_ childVC: UIViewController)
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
        bottomSearchBar.render(props.bottomSearchBar)
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
    
    func showChildViewControllerWithAnimation(_ childVC: UIViewController) {
        addChild(childVC)
        view.insertSubview(childVC.view, belowSubview: bottomSearchBar)

        childVC.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSearchBar.snp.top)
        }

        childVC.view.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
        childVC.view.alpha = 0

        childVC.didMove(toParent: self)

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            childVC.view.transform = .identity
            childVC.view.alpha = 1
        }
        keyboardWillHide()
        bottomSearchBar.searchTextField.endEditing(true)
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
