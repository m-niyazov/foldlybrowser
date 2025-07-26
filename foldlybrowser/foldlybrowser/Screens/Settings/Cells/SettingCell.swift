//
//  SettingCell.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

final class SettingCell: UITableViewCell {
    // MARK: - Views
    private let iconContainer = UIView()
    private let iconImageView = UIImageView()
    private let label = UILabel()
    private let chevronImageView = UIImageView()

    // MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func render(_ data: SettingsProps.SettingCell) {
        label.text = data.text
        iconContainer.backgroundColor = data.iconBackgroundColor

        let isPremiumCell = data.icon == "crown.fill"
        layer.masksToBounds = isPremiumCell
        layer.borderColor = isPremiumCell ? UIColor.white.cgColor : nil
        layer.borderWidth = isPremiumCell ? 1 : 0


        let icon = UIImage(systemName: data.icon)?.withTintColor(
            .white,
            renderingMode: .alwaysOriginal
        )
        iconImageView.image = icon
    }

    // MARK: - Private Methods

    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white
        iconContainer.do {
            $0.layer.cornerRadius = 5
        }

        label.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .black
        }
        
        chevronImageView.do {
            $0.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        }
    }

    private func addSubviews() {
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(chevronImageView)
    }

    private func setupConstraints() {
        iconContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(30)
            $0.top.bottom.equalToSuperview().inset(10).priority(.medium)
        }

        iconImageView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.center.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(16)
            $0.width.equalTo(10)
        }
    }
}
