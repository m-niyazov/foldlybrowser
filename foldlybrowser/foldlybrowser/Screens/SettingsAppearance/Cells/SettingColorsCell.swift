//
//  SettingColorsCell.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

final class SettingColorsCell: UITableViewCell {

    // MARK: - Views
    private let colorView = UIView()
    private let label = UILabel()
    private let checkmarkImageView = UIImageView()
    
    // MARK: - Constants
    private enum Layout {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 10
        static let colorSize: CGFloat = 30
        static let colorCornerRadius: CGFloat = 10
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func render(_ data: SettingsAppearanceProps.SettingColorCell, userSelectedColor: UIColor?) {
        colorView.backgroundColor = data.color
        label.text = data.text
        checkmarkImageView.isHidden = (data.color != userSelectedColor)
    }
    
    func setChecked(_ checked: Bool) {
        checkmarkImageView.isHidden = !checked
    }

    // MARK: - Private Setup
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        colorView.layer.cornerRadius = Layout.colorCornerRadius

        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        
        checkmarkImageView.isHidden = true
        checkmarkImageView.image = UIImage(systemName: "checkmark")
    }

    private func setupLayout() {
        contentView.addSubview(colorView)
        contentView.addSubview(label)
        contentView.addSubview(checkmarkImageView)

        colorView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.horizontalInset)
            $0.size.equalTo(Layout.colorSize)
            $0.top.bottom.equalToSuperview().inset(Layout.verticalInset).priority(.medium)
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(Layout.horizontalInset)
            $0.trailing.equalToSuperview().inset(Layout.horizontalInset)
            $0.centerY.equalToSuperview()
        }
        
        checkmarkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(16)
        }
    }
}
