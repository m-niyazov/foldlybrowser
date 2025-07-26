//
//  SettingThemeCell.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

final class SettingThemeCell: UITableViewCell {

    // MARK: - Views
    private let label = UILabel()
    private let switchView = UISwitch()

    // MARK: - Callbacks
    var onSwitchChanged: ((Bool) -> Void)?

    // MARK: - Constants
    private enum Layout {
        static let horizontalInset: CGFloat = 16
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func render(_ data: SettingsAppearanceProps.SettingAppearanceCell) {
        label.text = data.text
        switchView.isOn = true
    }

    // MARK: - Private Setup
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
    }

    private func setupLayout() {
        contentView.addSubview(label)
        contentView.addSubview(switchView)

        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Layout.horizontalInset)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(switchView.snp.leading).offset(-8)
        }

        switchView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Layout.horizontalInset)
        }
    }

    private func setupActions() {
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }

    @objc private func switchChanged(_ sender: UISwitch) {
        onSwitchChanged?(sender.isOn)
    }
}
