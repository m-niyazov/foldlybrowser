//
//  SettingColorsCell.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

final class SettingSearchEngineCell: UITableViewCell {

    // MARK: - Views
    private let engineImageView = UIImageView()
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
    func render(_ data: SettingsSearchEngineProps.SettingSearchEngineCell, userSelectedSearchEngine: SearchEngine) {
        engineImageView.image = UIImage(named: data.searchEngine.iconName)
        label.text = data.searchEngine.name
        checkmarkImageView.isHidden = (data.searchEngine != userSelectedSearchEngine)
    }
    
    func setChecked(_ checked: Bool) {
        checkmarkImageView.isHidden = !checked
    }

    // MARK: - Private Setup
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        engineImageView.layer.cornerRadius = Layout.colorCornerRadius

        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        
        checkmarkImageView.isHidden = true
        checkmarkImageView.image = UIImage(systemName: "checkmark")
    }

    private func setupLayout() {
        contentView.addSubview(engineImageView)
        contentView.addSubview(label)
        contentView.addSubview(checkmarkImageView)

        engineImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.horizontalInset)
            $0.size.equalTo(Layout.colorSize)
            $0.top.bottom.equalToSuperview().inset(Layout.verticalInset).priority(.medium)
        }

        label.snp.makeConstraints {
            $0.leading.equalTo(engineImageView.snp.trailing).offset(Layout.horizontalInset)
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
