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

    private let homeButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    private let menuButton = UIButton(type: .system)
    private let closeButton = UIButton(type: .system)

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
            self.searchTextFieldContainerWidthLessConstraint.update(priority: .low)
            self.searchTextFieldContainerWidthEqualConstraint.activate()
            self.searchTextFieldContainerWidthEqualConstraint.update(priority: .high)
            self.superview?.layoutIfNeeded()
        }
    }

    func makeSearchBarInActive() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.bluryBackgroundHeightConstraint.update(offset: 0)
            self.searchTextFieldContainerWidthLessConstraint.update(priority: .high)
            self.searchTextFieldContainerWidthEqualConstraint.deactivate()
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
            $0.backgroundColor = .systemGray6
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 5
            $0.alignment = .center
            $0.layer.cornerRadius = 22.5
            $0.layer.borderColor = UIColor.systemGray5.cgColor
            $0.layer.borderWidth = 1
            $0.layoutMargins = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 0)
            $0.isLayoutMarginsRelativeArrangement = true
        }

        searchEngineIcon.do {
            $0.contentMode = .scaleAspectFit
            $0.image = .googleIcon
        }

        searchTextField.do {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12, height: 10))
            let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12, height: 10))
            $0.leftView = leftView
            $0.rightView = rightView
            $0.rightViewMode = .unlessEditing
            $0.leftViewMode = .always
            $0.backgroundColor = .systemGray5
            $0.clearButtonMode = .whileEditing
            $0.placeholder = "Search or enter website"
            $0.borderStyle = .none
            $0.clearButtonMode = .whileEditing
            $0.layer.cornerRadius = 22.5
            $0.font = .preferredFont(forTextStyle: .body)
            $0.returnKeyType = .go
            $0.delegate = self
        }


        homeButton.do {
            $0.setImage(
                UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)),
                for: .normal
            )
            $0.addTarget(self, action: #selector(tapHome), for: .touchUpInside)
        }

        backButton.do {
            $0.setImage(.init(systemName: "chevron.backward"), for: .normal)
        }

        menuButton.do {
            $0.setImage(.init(systemName: "ellipsis"), for: .normal)
        }
        
        [homeButton, backButton, menuButton, closeButton].forEach {
            $0.layer.cornerRadius = 17.5
            $0.tintColor = .black
            $0.backgroundColor = .systemGray5
        }
    }

    func addSubviews() {
        addSubview(bluryBackground)
        bluryBackground.contentView.addSubview(contentView)
        contentView.addSubview(searchTextFieldContainer)
        contentView.addSubview(homeButton)
        searchTextFieldContainer.addArrangedSubview(searchEngineIcon)
        searchTextFieldContainer.addArrangedSubview(searchTextField)

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

        homeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(35)
            $0.trailing.equalTo(searchTextFieldContainer.snp.leading).offset(-16)
        }

        searchTextFieldContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            self.searchTextFieldContainerWidthLessConstraint = $0.width.lessThanOrEqualToSuperview().priority(.high).constraint
            self.searchTextFieldContainerWidthEqualConstraint = $0.width.equalToSuperview().priority(.low).constraint
            $0.centerX.equalToSuperview()
        }

        searchEngineIcon.snp.makeConstraints {
            $0.size.equalTo(22.5)
        }

        searchTextField.snp.makeConstraints {
            $0.height.equalTo(45)
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
