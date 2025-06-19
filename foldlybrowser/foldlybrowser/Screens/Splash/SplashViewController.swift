// 
//  SplashViewController.swift
//  foldlybrowser
//
//  Created by Niyazov on 13.02.2023.
//

import UIKit
import Lottie
import FirebaseAnalytics
import SnapKit

protocol SplashViewControllerProtocol: AnyObject {
}

final class SplashViewController: UIViewController, SplashViewControllerProtocol {
    // MARK: - Properties
    // swiftlint: disable implicitly_unwrapped_optional
    var presenter: SplashPresenterProtocol!
    // swiftlint: enable implicitly_unwrapped_optional

    // MARK: - Views
    let backgroundImageView = UIImageView()
    private var backgroundImageBlackLayer = UIView()
    private var activityIndicatorView = LottieAnimationView()
    private let appIconImageContainer = UIView()
    private let appIconImage = UIImageView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addViews()
        setupConstraints()
        presenter.checkUserStatus()
    }
}

// MARK: - Private Methods
private extension SplashViewController {
    func setupView() {
        view.backgroundColor = .white
        backgroundImageView.do {
            $0.image = UIImage()
        }

        backgroundImageBlackLayer.do {
            $0.backgroundColor = .black.withAlphaComponent(0.2)
        }

        appIconImage.do {
            $0.image = UIImage()
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = (view.frame.height * 0.15) * 0.20
        }

        appIconImageContainer.do {
            $0.layer.cornerRadius = 27
            $0.layer.borderWidth = 0
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
            $0.layer.shadowRadius = 10
            $0.layer.shadowOpacity = 0.7
            $0.layer.masksToBounds = false
        }

        activityIndicatorView.do {
//            let animationName = LottieAnimations.circleActivityIndicator.rawValue
//            $0.animation = LottieAnimation.named(animationName)
            $0.loopMode = .loop
            // $0.layer.opacity = 0.75
            $0.isUserInteractionEnabled = false
            $0.play()
        }
    }

    func addViews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(backgroundImageBlackLayer)
        view.addSubview(activityIndicatorView)
        view.addSubview(appIconImageContainer)
        appIconImageContainer.addSubview(appIconImage)
    }

    func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        backgroundImageBlackLayer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        appIconImageContainer.snp.makeConstraints {
            $0.size.equalTo(view.frame.height * 0.2)
            $0.center.equalToSuperview()
        }

        appIconImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        activityIndicatorView.snp.makeConstraints {
            $0.size.equalTo(view.frame.height * 0.32)
            $0.center.equalTo(appIconImageContainer)
        }
    }
}
