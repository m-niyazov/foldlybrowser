//
//  HomeSearchTrendsCell.swift
//  foldlybrowser
//
//  Created by TapticGroup on 22/06/2025.
//

import Foundation
import UIKit

class HomeSearchTrendsCell: UICollectionViewCell {
    // MARK: - Views
    private let titleLabel = UILabel()
    private let listContainerView = UIStackView()

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

    func render() {
    }

    private func setupView() {
        self.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 22.5
        }

        listContainerView.do {
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 10
        }

        titleLabel.do {
            $0.text = "Trending Now in US 🇺🇸"
            $0.setPreferredFontWithWeight(style: .title3, weight: .semibold)
            $0.textColor = .label
        }
    }

    private func addViews() {
        addSubview(titleLabel)
        addSubview(listContainerView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        listContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
