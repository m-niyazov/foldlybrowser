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
    private let mainImageContainer = UIView()
    private let folderIconImageView = UIImageView()

    private let siteIconImageView = UIImageView()

    private let emojiLabelContainer = UIView()
    private let emojiLabel = UILabel()

    private let nameLabel = UILabel()

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

        emojiLabelContainer.isHidden = true
        emojiLabel.isHidden = true
    }

    private func setupView() {
        self.do {
            $0.backgroundColor = .none
        }

        mainImageContainer.do {
            $0.backgroundColor = .systemGray4
            $0.contentMode = .scaleAspectFit
            $0.layer.cornerRadius = 10
        }

        folderIconImageView.do {
            let configuration = UIImage.SymbolConfiguration(weight: .light)
            $0.image = UIImage(systemName: "folder", withConfiguration: configuration)
            //$0.image = .FolderIcons.folderWh
            $0.tintColor = .white
            $0.contentMode = .scaleAspectFill
        }

        nameLabel.do {
            $0.font = .systemFont(ofSize: 11, weight: .medium)
            $0.textColor = .label
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }

        emojiLabelContainer.do {
            $0.backgroundColor = .systemGray4
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 13.5
            $0.layer.borderColor = UIColor.white.cgColor

            $0.layer.shadowColor = UIColor.white.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
            $0.layer.shadowRadius = 5
            $0.layer.shadowOpacity = 1
        }

        emojiLabel.do {
            $0.font = .systemFont(ofSize: 15)
            $0.textAlignment = .center
        }
    }

    private func addViews() {
        contentView.addSubview(mainImageContainer)
        mainImageContainer.addSubview(folderIconImageView)
        folderIconImageView.addSubview(emojiLabelContainer)
        emojiLabelContainer.addSubview(emojiLabel)
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        mainImageContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }

        folderIconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(7)
        }

        emojiLabelContainer.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(27)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageContainer.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }

        emojiLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

