//
//  HomeSectionTitleCell.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit

class HomeSectionTitleCell: UICollectionViewCell {
    // MARK: - Views
    private let titleLabel = UILabel()
    private let subtitlLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    private let mainStackView = UIStackView()
    private let labelsStackView = UIStackView()
    private var actionButtonAction: ((HomeProps.SectionTitleProps.ButtonType) -> Void)?
    private var actionButtontype: HomeProps.SectionTitleProps.ButtonType?

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

    func render(_ props: HomeProps.SectionTitleProps) {
        titleLabel.text = props.title
        if let subtitle = props.subtitle {
            subtitlLabel.text = subtitle
            labelsStackView.addArrangedSubview(subtitlLabel)
        }

        if let buttontype = props.buttontype {
            self.actionButtontype = buttontype
            mainStackView.alignment = .top
            switch buttontype {
            case .seeAllFavorites:
                actionButton.setTitle("See All", for: .normal)
            case .importFolder:
                actionButton.setTitle("Import", for: .normal)
            case .closeAds:
                actionButton.setImage(.init(systemName: "square.and.arrow.up"), for: .normal)
            }
            mainStackView.addArrangedSubview(actionButton)
            actionButtonAction = props.select
        }
    }

    private func setupView() {
        self.do {
            $0.backgroundColor = .none
        }

        mainStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }

        labelsStackView.do {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 3
        }

        titleLabel.do {
            $0.setPreferredFontWithWeight(style: .title2, weight: .bold)
            $0.textColor = .label
        }

        subtitlLabel.do {
            $0.font = .preferredFont(forTextStyle: .subheadline)
            $0.textColor = .secondaryLabel
            $0.numberOfLines = 0
        }

        actionButton.do {
            $0.setTitleColor(.accent, for: .normal)
            $0.titleLabel?.font = .preferredFont(forTextStyle: .callout)
            $0.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        }
    }

    @objc func handleActionButton() {
        if let actionButtontype = actionButtontype {
            actionButtonAction?(actionButtontype)
        }
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
    }
}
