//
//  HomeBottomSearchBar.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit
import SnapKit

final class HomeBottomSearchBar: UIView {

    var isWebviewActive: Bool = false {
         didSet {
             if oldValue != isWebviewActive {
                 webviewStateChanged(isWebviewActive)
             }
         }
     }

    private var selectedSearchEngine: SearchEngine? {
        didSet {
            if oldValue != selectedSearchEngine {
                setSearchEngineIconImage()
            }
        }
    }

    private var currentURL: URL?

    // MARK: – Subviews
    private let bluryBackground = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private let progressView = UIProgressView(progressViewStyle: .default)
    private var bluryBackgroundHeightConstraint: Constraint!
    private let contentView = UIView()

    private let searchTextFieldContainer = UIStackView()
    private var searchTextFieldContainerWidthEqualConstraint: Constraint!
    private var searchTextFieldContainerWidthLessConstraint: Constraint!
    private var bottomContainerConstraint: Constraint!
    private var widthEqualConstraint: Constraint!
    let searchTextField = UITextField()
    private let searchEngineIcon = UIImageView()
    private let searchEngineIconContainer = UIView()
    private let refreshButton = UIButton(type: .system)

    private let bottomContainer = UIView()
    private let backButton = UIButton(type: .system)
    private let forwardButton = UIButton(type: .system)
    private let leadingButtonsStackView = UIStackView()

    private let homeButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let menuButton = UIButton(type: .system)

    // MARK: – Public callbacks
    var didTapSearch: ((String) -> Void)?
    var didTapHome: (() -> Void)?
    var didTapBack: (() -> Void)?
    var didTapForward: (() -> Void)?
    var didTapSave: (() -> Void)?

    // MARK: – Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func render(_ props: HomeProps.HomeBottomSearchBarProps) {
        self.isWebviewActive = props.isWebviewActive
        self.selectedSearchEngine = props.selectedSearchEngine
        didTapSearch = props.didTapSearch
        didTapHome = props.didTapHome
        didTapBack = props.didTapMoveBackPage
        didTapForward = props.didTapMoveForwardPage
        didTapSave = props.didTapSavePage
    }

    func update(_ props: HomeProps.HomeBottomSearchBarProps) {
        self.isWebviewActive = props.isWebviewActive
        self.selectedSearchEngine = props.selectedSearchEngine
    }

    func webviewStateChanged(_ isActive: Bool) {
        if isActive {
            setupWebpageObserver()
        } else {
            removeWebpageObserver()
            currentURL = nil
            searchTextField.text = String()
            progressView.progress = .zero
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: [
            isActive ? .curveEaseIn : .curveEaseOut
        ]) {
            self.searchEngineIconContainer.isHidden = isActive
            self.searchTextFieldContainer.layoutMargins.left = isActive ? 0 : 6
            self.searchTextFieldContainer.layoutMargins.right = !isActive ? 0 : 6
            self.refreshButton.isHidden = !isActive

            self.bottomContainer.alpha = isActive ? 1 : 0
            self.bottomContainerConstraint.update(offset: isActive ? 0 : 50)
            if isActive == false {
                self.superview?.layoutIfNeeded()
            }
        } completion: { isFinished in
            guard isFinished == true else {
                return
            }
            self.bottomContainer.isHidden = !isActive
        }
    }

    func keyboardWillShow(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn]) {
            self.bluryBackgroundHeightConstraint.update(offset: keyboardHeight + 45 + 20)
            self.superview?.layoutIfNeeded()
        }
    }

    func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.bluryBackgroundHeightConstraint.update(offset: 0)
            self.superview?.layoutIfNeeded()
        }
    }
}

// MARK: – Private
private extension HomeBottomSearchBar {

    func setupView() {
        backgroundColor = .none

        contentView.do {
            $0.backgroundColor = .none
        }

        bluryBackground.do {
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
        }

        progressView.do {
            $0.sizeToFit()
            $0.backgroundColor = .clear
            $0.trackTintColor = .clear
            $0.progressTintColor = UIColor.accent
        }

        searchTextFieldContainer.do {
            $0.backgroundColor = UIColor.systemGray6
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.layer.cornerRadius = 25
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.layer.masksToBounds = true
            $0.layoutMargins = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
            $0.isLayoutMarginsRelativeArrangement = true
        }

        searchEngineIconContainer.do {
            $0.backgroundColor = .none
        }

        searchEngineIcon.do {
            $0.contentMode = .scaleAspectFit
        }

        refreshButton.do {
            $0.setImage(
                .init(
                    systemName: "arrow.clockwise",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
                ),
                for: .normal
            )
            $0.tintColor = .black
            $0.isHidden = true
        }

        searchTextField.do {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15, height: 10))
            let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15, height: 10))
            $0.leftView = leftView
            $0.rightView = rightView
            $0.rightViewMode = .unlessEditing
            $0.leftViewMode = .always
            $0.backgroundColor = .white
            $0.clearButtonMode = .whileEditing
            $0.placeholder = "Search or enter website"
            $0.borderStyle = .none
            $0.layer.cornerRadius = 25
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.font = .preferredFont(forTextStyle: .body)
            $0.returnKeyType = .go
            $0.delegate = self
        }

        leadingButtonsStackView.do {
            $0.spacing = 15
            $0.axis = .horizontal
        }

        bottomContainer.do {
            $0.alpha = 0
        }

        [backButton, menuButton, forwardButton].forEach {
            $0.layer.cornerRadius = 17.5
            $0.tintColor = .black
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.backgroundColor = .systemGray5.withAlphaComponent(0.6)
        }

        backButton.do {
            $0.setImage(
                .init(
                    systemName: "chevron.backward",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
                ),
                for: .normal
            )
            $0.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        }

        forwardButton.do {
            $0.setImage(
                .init(
                    systemName: "chevron.forward",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
                ),
                for: .normal
            )
            $0.addTarget(self, action: #selector(tapForward), for: .touchUpInside)
        }

        homeButton.do {
            $0.setImage(.cmHomeIcon.withRenderingMode(.alwaysOriginal), for: .normal)
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            configuration.imagePadding = 8
            configuration.attributedTitle = .init("Back To Home", attributes: .init([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.accent.cgColor,
            ]))
            $0.configuration = configuration
            $0.backgroundColor = .accent.withAlphaComponent(0.07)
            $0.tintColor = .accent
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(tapHome), for: .touchUpInside)
        }


        saveButton.do {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            //  configuration.imagePadding = 5
            configuration.attributedTitle = .init("Save", attributes: .init([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,
            ]))
            $0.configuration = configuration
            $0.backgroundColor = UIColor.systemGray5
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.tintColor = .black
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        }
    }

    func setSearchEngineIconImage() {
        guard let selectedSearchEngine = self.selectedSearchEngine else {
            return
        }
        switch selectedSearchEngine {
        case .google:
            searchEngineIcon.image = .googleSEngineIcon
        case .duckduckgo:
            searchEngineIcon.image = .duckSEngineIcon
        case .bing:
            searchEngineIcon.image = .bingSEngineIcon
        case .yandex:
            searchEngineIcon.image = .yandexSEngineIcon
        }
    }

    func addSubviews() {
        addSubview(progressView)
        addSubview(bluryBackground)
        bluryBackground.contentView.addSubview(contentView)
        contentView.addSubview(searchTextFieldContainer)
        searchTextFieldContainer.addArrangedSubview(searchEngineIconContainer)
        searchEngineIconContainer.addSubview(searchEngineIcon)
        searchTextFieldContainer.addArrangedSubview(searchTextField)
        searchTextFieldContainer.addArrangedSubview(refreshButton)
        contentView.addSubview(bottomContainer)
        bottomContainer.addSubview(leadingButtonsStackView)
        leadingButtonsStackView.addArrangedSubview(backButton)
        leadingButtonsStackView.addArrangedSubview(forwardButton)
        bottomContainer.addSubview(homeButton)
        bottomContainer.addSubview(saveButton)

        progressView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.leading.trailing.equalToSuperview()
        }

        bluryBackground.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.low)
            self.bluryBackgroundHeightConstraint = $0.height.greaterThanOrEqualTo(0).constraint
        }

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide)
        }

        searchEngineIconContainer.snp.makeConstraints {
            $0.size.equalTo(33)
        }

        searchEngineIcon.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchTextFieldContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        searchTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        refreshButton.snp.makeConstraints {
            $0.size.equalTo(33)
        }

        bottomContainer.snp.makeConstraints {
            $0.top.equalTo(searchTextFieldContainer.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            bottomContainerConstraint = $0.bottom.equalToSuperview().offset(50).constraint
        }

        homeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        leadingButtonsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(homeButton.snp.leading).offset(-5)
            $0.centerY.equalTo(homeButton)
        }

        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(homeButton.snp.trailing).offset(5)
            $0.height.equalTo(homeButton)
            $0.centerY.equalTo(homeButton)
        }

        [backButton, forwardButton].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(35)
            }
        }
    }

    // MARK: – Actions
    @objc func tapHome() {
        didTapHome?()
    }

    @objc func tapBack() {
        didTapBack?()
    }

    @objc func tapForward() {
        didTapForward?()
    }

    @objc func tapSave() {
        didTapSave?()
    }

}

// MARK: – Observers
extension HomeBottomSearchBar {
    func setupWebpageObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(webpageDidUpdateProgress(_:)),
            name: .webpageDidUpdateProgress,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleURLUpdate(_:)),
            name: .webpageDidUpdateURL,
            object: nil
        )
    }

    func removeWebpageObserver(){
        NotificationCenter.default.removeObserver(self, name: .webpageDidUpdateProgress, object: nil)
        NotificationCenter.default.removeObserver(self, name: .webpageDidUpdateURL, object: nil)
    }

    @objc private func webpageDidUpdateProgress(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let progress = userInfo["progress"] as? Double else { return }
        if progress >= 1.0 {
            progressView.setProgress(0.0, animated: false)
        } else {
            progressView.setProgress(Float(progress), animated: true)
        }
    }

    @objc private func handleURLUpdate(_ notification: Notification) {
        if let urlString = notification.userInfo?["url"] as? String,
           let url = URL(string: urlString) {
            currentURL = url
            searchTextField.text = SearchURLBuilder.displayNonEditing(url)
        }
    }

}

// MARK: – UITextFieldDelegate
extension HomeBottomSearchBar: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isWebviewActive == false,
           let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           text.isEmpty {
            textField.endEditing(true)
            return false
        } else {
            didTapSearch?(textField.text ?? "")
            textField.endEditing(true)
            return true
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let url = currentURL, let engine = selectedSearchEngine else {
            return
        }
        textField.text = SearchURLBuilder.displayEditing(url, engine: engine)
        textField.selectAll(nil)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let url = currentURL else {
            return
        }
        textField.text = SearchURLBuilder.displayNonEditing(url)
    }
}
