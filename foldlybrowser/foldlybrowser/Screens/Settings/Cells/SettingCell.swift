//
//  SettingCell.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit
import SnapKit

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

        guard !data.icon.isEmpty else {
            iconContainer.isHidden = true
            iconImageView.isHidden = true

            label.snp.remakeConstraints {
                $0.leading.equalToSuperview().inset(16)
                $0.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
                $0.centerY.equalToSuperview()
            }
            return
        }

        iconContainer.isHidden = false
        iconImageView.isHidden = false
        iconContainer.backgroundColor = data.iconBackgroundColor

        var icon: UIImage?
        if let assetIcon = UIImage(named: data.icon) {
            icon = assetIcon
            iconImageView.tintColor = nil
        } else if let sfIcon = UIImage(systemName: data.icon) {
            icon = sfIcon.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .white
        }

        iconImageView.image = icon

        iconContainer.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(30)
            $0.centerY.equalToSuperview()
        }

        iconImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(20)
        }

        label.snp.remakeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(16)
            $0.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Private Methods

    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        iconContainer.do {
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }

        iconImageView.do {
            $0.contentMode = .scaleAspectFit
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
            $0.centerY.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(20)
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(16)
            $0.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
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
