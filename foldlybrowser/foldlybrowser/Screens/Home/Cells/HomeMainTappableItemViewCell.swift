//
//  HomeFolderViewCell.swift
//  foldlybrowser
//
//  Created by TapticGroup on 22/06/2025.
//

import Foundation
import UIKit

class HomeMainTappableItemViewCell: UICollectionViewCell {
    // MARK: - Views
    private let mainContainerView = UIView()

    private let topContainerView = UIStackView()

    private let folderTopView = FolderTopView()
    private let websiteTopView = WebsiteTopView()
    private let addNewTopView = AddNewTopView()

    private let bottomContainerView = UIStackView()

    private let nameLabel = UILabel()
    private let itemsCountLabel = UILabel()

    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        // Сброс изображений
//        folderIconImageView.image = nil
//        folderIconImageView.tintColor = .white
//
//        // Сброс фона
//        mainContainerView.backgroundColor = .systemGray4
//
//        // Сброс текста
//        nameLabel.text = nil
//        nameLabel.isHidden = false
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Mthods

    func render(_ props: HomeProps.MainTappableItem) {
        switch props {
        case .folder(let folderData):
            topContainerView.addArrangedSubview(folderTopView)
            nameLabel.text = folderData.name
            itemsCountLabel.text = "0 sites"
        case .website(let websiteData):
            topContainerView.addArrangedSubview(websiteTopView)
            nameLabel.text = websiteData.name
        case .addNew:
            topContainerView.addArrangedSubview(addNewTopView)
        }
    }

    private func setupView() {
        self.do {
            $0.backgroundColor = .none
        }

        topContainerView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.layer.masksToBounds = true
        }

        bottomContainerView.do {
            $0.axis = .vertical
            $0.spacing = 0
        }

        nameLabel.do {
            $0.font = .systemFont(ofSize: 13, weight: .regular)
            $0.textColor = .label
            $0.textAlignment = .center
            $0.numberOfLines = 2
        }

        itemsCountLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .regular)
            $0.textColor = .gray
            $0.textAlignment = .center
        }
    }

    private func addViews() {
        contentView.addSubview(mainContainerView)
        mainContainerView.addSubview(topContainerView)
        mainContainerView.addSubview(bottomContainerView)
        bottomContainerView.addArrangedSubview(nameLabel)
        bottomContainerView.addArrangedSubview(itemsCountLabel)
    }

    private func setupConstraints() {
        mainContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        topContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        bottomContainerView.snp.makeConstraints {
            $0.top.equalTo(topContainerView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }

    }
}

class FolderTopView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .folderIcon
        imageView.tintColor = .defaultFolder
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: – Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.center.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(80)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

class WebsiteTopView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appleLogoBlack
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: – Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.center.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(70)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

class AddNewTopView: UIView {
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 48 / 2
        button.backgroundColor = .accent.withAlphaComponent(0.1)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitleColor(.accent, for: .normal)
        return button
    }()

    // MARK: – Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.center.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(70)
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
