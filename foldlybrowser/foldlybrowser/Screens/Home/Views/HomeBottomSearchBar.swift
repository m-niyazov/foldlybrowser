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

    // MARK: – Subviews
    private let bluryBackground = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private var bluryBackgroundHeightConstraint: Constraint!
    private let contentView = UIView()

    private let searchTextFieldContainer = UIStackView()
    private var searchTextFieldContainerWidthEqualConstraint: Constraint!
    private var searchTextFieldContainerWidthLessConstraint: Constraint!
    private var widthEqualConstraint: Constraint!
    let searchTextField = UITextField()
    private let searchEngineIcon = UIImageView()
    private let refreshButton = UIButton(type: .system)

    private let bottomContainer = UIView()
    private let backButton = UIButton(type: .system)
    private let forwardButton = UIButton(type: .system)
    private let leadingButtonsStackView = UIStackView()

    private let homeButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let menuButton = UIButton(type: .system)

    // MARK: – Public callbacks
    var didTapHome: (() -> Void)?
    var didTapBack: (() -> Void)?
    var didTapMenu: (() -> Void)?
    var didTapSearch: ((String) -> Void)?

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
        didTapSearch = props.didTapSearch
        didTapHome = props.didTapHome
    }

    func makeSearchBarActive(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn]) {
            self.bluryBackgroundHeightConstraint.update(offset: keyboardHeight + 45 + 20)
            // self.searchTextFieldContainerWidthLessConstraint.update(priority: .low)
            // self.searchTextFieldContainerWidthEqualConstraint.activate()
            // self.searchTextFieldContainerWidthEqualConstraint.update(priority: .high)
            self.superview?.layoutIfNeeded()
        }
    }

    func makeSearchBarInActive() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.bluryBackgroundHeightConstraint.update(offset: 0)
            // self.searchTextFieldContainerWidthLessConstraint.update(priority: .high)
            // self.searchTextFieldContainerWidthEqualConstraint.deactivate()
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

        searchTextFieldContainer.do {
            $0.backgroundColor = .white
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .center
            $0.layer.cornerRadius = 25
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            $0.isLayoutMarginsRelativeArrangement = true
        }

        searchEngineIcon.do {
            $0.contentMode = .scaleAspectFit
            $0.image = .googleIcon
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
        }

        searchTextField.do {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12, height: 10))
            let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12, height: 10))
            $0.leftView = leftView
            $0.rightView = rightView
            $0.rightViewMode = .unlessEditing
            $0.leftViewMode = .always
            $0.backgroundColor = .none
            $0.clearButtonMode = .whileEditing
            $0.placeholder = "Search or enter website"
//            $0.attributedPlaceholder = NSAttributedString(
//                string: "Search or enter website",
//                attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray]
//            )
            $0.borderStyle = .none
            $0.clearButtonMode = .whileEditing
            $0.layer.cornerRadius = 0
            $0.font = .preferredFont(forTextStyle: .body)
            $0.returnKeyType = .go
            $0.delegate = self
        }

        leadingButtonsStackView.do {
            $0.spacing = 10
            $0.axis = .horizontal
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
        }

        forwardButton.do {
            $0.setImage(
                .init(
                    systemName: "chevron.forward",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
                ),
                for: .normal
            )
        }

        menuButton.do {
            $0.setImage(
                .init(
                    systemName: "ellipsis",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
                ),
                for: .normal
            )
        }


        homeButton.do {
            $0.setImage(.cmHomeIcon.withRenderingMode(.alwaysOriginal), for: .normal)
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12)
            configuration.imagePadding = 8
            configuration.attributedTitle = .init("Back To Home", attributes: .init([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.accent.cgColor,
            ]))
            $0.configuration = configuration
            $0.backgroundColor = .accent.withAlphaComponent(0.08)
            $0.tintColor = .accent
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(tapHome), for: .touchUpInside)
        }


        saveButton.do {
            $0.setImage(
                .init(
                    systemName: "plus",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize:11, weight: .bold)
                ),
                for: .normal
            )
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12)
            configuration.imagePadding = 5
            configuration.attributedTitle = .init("Save", attributes: .init([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.black.cgColor,
            ]))
            $0.configuration = configuration
            $0.backgroundColor = UIColor.systemGray5
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.tintColor = .black
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
        }

    }

    func addSubviews() {
        addSubview(bluryBackground)
        bluryBackground.contentView.addSubview(contentView)
        contentView.addSubview(searchTextFieldContainer)
        searchTextFieldContainer.addArrangedSubview(searchEngineIcon)
        searchTextFieldContainer.addArrangedSubview(searchTextField)
        searchTextFieldContainer.addArrangedSubview(refreshButton)
        contentView.addSubview(bottomContainer)
        bottomContainer.addSubview(leadingButtonsStackView)
        leadingButtonsStackView.addArrangedSubview(backButton)
        leadingButtonsStackView.addArrangedSubview(forwardButton)
        bottomContainer.addSubview(homeButton)
        bottomContainer.addSubview(saveButton)

        bluryBackground.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.low)
            self.bluryBackgroundHeightConstraint = $0.height.greaterThanOrEqualTo(0).constraint
        }

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide)
        }

        searchEngineIcon.snp.makeConstraints {
            $0.size.equalTo(25)
        }

        searchTextFieldContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            // self.searchTextFieldContainerWidthLessConstraint = $0.width.lessThanOrEqualToSuperview().priority(.high).constraint
            // self.searchTextFieldContainerWidthEqualConstraint = $0.width.equalToSuperview().priority(.low).constraint
            $0.centerX.equalToSuperview()
        }

        searchTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        refreshButton.snp.makeConstraints {
            $0.size.equalTo(30)
        }

        bottomContainer.snp.makeConstraints {
            $0.top.equalTo(searchTextFieldContainer.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        homeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        leadingButtonsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(homeButton)
        }

        saveButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
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
    @objc func tapBack() {
        didTapBack?()
    }

    @objc func tapMenu() {
        didTapMenu?()
    }

    @objc func tapHome() {
        didTapHome?()
    }
}

// MARK: – UITextFieldDelegate
extension HomeBottomSearchBar: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSearch?(textField.text ?? "")
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
