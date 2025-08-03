// 
//  HomeViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 20/06/2025.
//

import UIKit
import SnapKit

protocol HomeViewControllerProtocol: AnyObject {
    func render(_ props: HomeProps)
    func update(_ props: HomeProps)
}

final class HomeViewController: KeyboardHandlingViewController, HomeViewControllerProtocol {
    
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: HomePresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    var props: HomeProps?

    // MARK: - Views
    var homeView = HomeView()
    let bluryTopStatusBarBackground = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    var webPageContainerView = UIView()
    let bottomSearchBar = HomeBottomSearchBar()
    private var bottomSearchBarConstraint: Constraint?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        setupView()
        addViews()
        setupConstraints()
        hideTabBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }

    // MARK: - Methods
    func render(_ props: HomeProps) {
        self.props = props
        homeView.render(props)
        bottomSearchBar.render(props.bottomSearchBar)
    }

    func update(_ props: HomeProps) {
        self.props = props
        homeView.update(props)
        bottomSearchBar.render(props.bottomSearchBar)
        toggleWebPageContainerView(show: props.isNeedToShowWebPage)
    }

    func keyboardWillShow(keyboardHeight: CGFloat) {
        bottomSearchBar.keyboardWillShow(keyboardHeight: keyboardHeight)
    }

    func keyboardWillHide() {
        bottomSearchBar.keyboardWillHide()
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
        keyboardHandlingRootView = view
        toggleWebPageContainerView(show: false)
    }
    
    func addViews() {
        view.addSubview(homeView)
        view.addSubview(webPageContainerView)
        view.addSubview(bottomSearchBar)
        view.addSubview(bluryTopStatusBarBackground)
    }
    
    func setupConstraints() {
        bluryTopStatusBarBackground.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        webPageContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSearchBar.snp.top)
        }

        bottomSearchBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            bottomSearchBarConstraint = $0.bottom.equalToSuperview().constraint
        }
    }

    @objc private func handleWebViewScroll(_ note: Notification) {
        guard let hide = note.userInfo?["isNeedToHide"] as? Bool else { return }

        UIView.animate(withDuration: 0.25, delay: 0, options: [
            hide ? .curveEaseIn : .curveEaseOut
        ]) {
            self.bottomSearchBarConstraint?.update(offset: hide ? 150 : 0)
            self.bottomSearchBar.alpha = hide ? 0 : 1
            self.view.layoutIfNeeded()
        }

    }

    func toggleWebPageContainerView(show: Bool) {
        if show {
            bottomSearchBar.endEditing(true)
        }
        if show && webPageContainerView.isHidden == true {
            bluryTopStatusBarBackground.isHidden = false
            webPageContainerView.isHidden = false
            webPageContainerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            webPageContainerView.alpha = 0
            NotificationCenter.default.addObserver(self, selector: #selector(handleWebViewScroll(_:)), name: .webViewDidScroll, object: nil)
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.webPageContainerView.transform = .identity
                self.webPageContainerView.alpha = 1
            }
        } else if show == false {
            bluryTopStatusBarBackground.isHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.webPageContainerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                self.webPageContainerView.alpha = 0
                self.bottomSearchBarConstraint?.update(offset: 0)
                NotificationCenter.default.removeObserver(self, name: .webViewDidScroll, object: nil)
            }) { _ in
                self.webPageContainerView.isHidden = true
                self.props?.removeAndDismissWebPage()
            }
        }
    }

}
