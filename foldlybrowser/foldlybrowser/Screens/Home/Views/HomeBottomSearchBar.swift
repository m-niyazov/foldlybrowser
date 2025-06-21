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
    private let searchTextField = UITextField()
    private let searchEngineIcon = UIImageView()

    private let homeButton = UIButton(type: .system)
    private let backButton = UIButton(type: .system)
    private let menuButton = UIButton(type: .system)
    private let closeSearchButton = UIButton(type: .system)

    // MARK: – Public callbacks
    var didTapBack: (() -> Void)?
    var didTapMenu: (() -> Void)?
    var didTapCancel: (() -> Void)?

    // MARK: – Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError()
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
        backgroundColor = .white

        contentView.do {
            $0.backgroundColor = .none
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


//        [homeButton, backButton, menuButton].forEach {
//            $0.tintColor = .label
//            $0.layer.cornerRadius = 20
//            $0.backgroundColor = .systemGray6
//        }
//
//        homeButton.do {
//            $0.setImage(.init(systemName: "house"), for: .normal)
//        }
//
//        backButton.do {
//            $0.setImage(.init(systemName: "chevron.backward"), for: .normal)
//        }
//
//        menuButton.do {
//            $0.setImage(.init(systemName: "ellipsis"), for: .normal)
//        }
    }

    func addSubviews() {
        addSubview(bluryBackground)
        bluryBackground.contentView.addSubview(contentView)
        contentView.addSubview(searchTextFieldContainer)
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

        searchEngineIcon.snp.makeConstraints {
            $0.size.equalTo(22.5)
        }

        searchTextFieldContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            self.searchTextFieldContainerWidthLessConstraint = $0.width.lessThanOrEqualToSuperview().priority(.high).constraint
            self.searchTextFieldContainerWidthEqualConstraint = $0.width.equalToSuperview().priority(.low).constraint
            $0.centerX.equalToSuperview()
        }

        searchTextField.snp.makeConstraints {
            $0.height.equalTo(45)
        }
    }

    // MARK: – UI updates
    func updateForEditing(active: Bool) {
        // 1. Скрываем / показываем back
        homeButton.isHidden = active
        backButton.isHidden = active
    }

    // MARK: – Actions
    @objc func tapBack() {
        didTapBack?()
    }

    @objc func tapMenu() {
        didTapMenu?()
    }

    @objc func tapMic() {
    }
}

// MARK: – UITextFieldDelegate
extension HomeBottomSearchBar: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateForEditing(active: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateForEditing(active: false)
    }
}
