// 
//  HomeViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func render(_ props: HomeProps)
    func update(_ props: HomeProps)
}

final class HomeViewController: KeyboardHandlingViewController, HomeViewControllerProtocol {
    
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: HomePresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: - Views
    var homeView = HomeView()
    var webPageContainerView = UIView()
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
        toggleWebPageContainerView(show: props.isNeedToShowWebPage)
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
        toggleWebPageContainerView(show: false)
//        webPageContainerView.do {
//            $0.isHidden = true
//            $0.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
//            $0.alpha = 0
//        }
    }
    
    func addViews() {
        view.addSubview(homeView)
        view.addSubview(webPageContainerView)
        view.addSubview(bottomSearchBar)
    }
    
    func setupConstraints() {
        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        webPageContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSearchBar.snp.top)
        }

        bottomSearchBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func toggleWebPageContainerView(show: Bool) {
        if show {
            bottomSearchBar.endEditing(true)
        }
        if show && webPageContainerView.isHidden == true {
            webPageContainerView.isHidden = false
            webPageContainerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            webPageContainerView.alpha = 0

            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.webPageContainerView.transform = .identity
                self.webPageContainerView.alpha = 1
            }
        } else if show == false {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.webPageContainerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                self.webPageContainerView.alpha = 0
            }) { _ in
                self.webPageContainerView.isHidden = true
            }
        }
    }

}
