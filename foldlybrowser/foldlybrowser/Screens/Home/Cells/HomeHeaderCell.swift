//
//  HomeHeaderCell.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit

class HomeHeaderCell: UICollectionViewCell {
    // MARK: - Views
    private let titleLabel = UILabel()
    private let subtitlLabel = UILabel()
    private let settingsButton = UIButton(type: .system)
    private let mainStackView = UIStackView()
    private let labelsStackView = UIStackView()
    private var actionButtonAction: (() -> Void)?

    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Mthods

    func render(_ props: HomeProps.HeaderProps) {
        titleLabel.text = "Browser"
        subtitlLabel.text = "Find, Share, Save"
        labelsStackView.insertArrangedSubview(subtitlLabel, at: 0)

        mainStackView.addArrangedSubview(settingsButton)
        actionButtonAction = props.tappedAppSettingsButton
    }

    private func setupView() {
        self.do {
            $0.backgroundColor = .none
        }

        mainStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }

        labelsStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 0.5
        }

        titleLabel.do {
            $0.font = .preferredFont(forTextStyle: .extraLargeTitle)
            $0.textColor = .label
        }

        subtitlLabel.do {
            $0.font = .preferredFont(forTextStyle: .headline)
            $0.textColor = .secondaryLabel
            $0.numberOfLines = 0
        }

        settingsButton.do {
            $0.layer.cornerRadius = 17.5
            $0.backgroundColor = .systemGray5
            $0.setImage(.init(systemName: "gear"), for: .normal)
            $0.setTitleColor(.accent, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            $0.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        }
    }

    @objc func handleActionButton() {
        actionButtonAction?()
    }

    private func addViews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
    }

    private func setupConstraints() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        settingsButton.snp.makeConstraints {
            $0.size.equalTo(35)
        }
    }
}
