//
//  HomeFolderViewCell.swift
//  foldlybrowser
//
//  Created by TapticGroup on 22/06/2025.
//

import Foundation
import UIKit

class HomeFolderViewCell: UICollectionViewCell {
    // MARK: - Views
    private let nameLabel = UILabel()
    private let folderImageView = UIImageView()
    private let emojiLabel = UILabel()

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

    func render(_ props: HomeProps.FolderProps) {
        nameLabel.text = props.name
        emojiLabel.text = props.emoji
    }

    private func setupView() {
        self.do {
            $0.backgroundColor = .none
        }

        folderImageView.do {
            $0.image = .FolderIcons.folderBlue
            $0.contentMode = .scaleAspectFit
        }

        nameLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .regular)
            $0.textColor = .label
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }

        emojiLabel.do {
            $0.font = .systemFont(ofSize: 30)
        }
    }

    private func addViews() {
        contentView.addSubview(folderImageView)
        folderImageView.addSubview(emojiLabel)
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        folderImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(folderImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }

        emojiLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(3.5)
        }
    }
}

