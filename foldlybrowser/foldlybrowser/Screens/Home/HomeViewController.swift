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

final class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: HomePresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    
    // MARK: - Views
    var homeView = HomeView()

    // MARK: - Lifecycle
    override func loadView() {
        view = homeView
    }

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
}

// MARK: - Private Methods

private extension HomeViewController {
    
    func setupView() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func addViews() {
    }
    
    func setupConstraints() {
    }
    
    // MARK: - UI Actions

}
