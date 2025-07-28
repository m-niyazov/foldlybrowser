//
//  SettingVersionCell.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

final class SettingVersionCell: UITableViewCell {
    // MARK: - Views
    private let titlelabel = UILabel()
    private let versionLabel = UILabel()

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

    func render(_ data: SettingsAboutAppProps.VersionCell) {
        titlelabel.text = data.title
        versionLabel.text = data.version
    }

    // MARK: - Private Methods

    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        titlelabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .black
        }
        
        versionLabel.do {
            $0.font = .systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .gray
        }
    }

    private func addSubviews() {
        contentView.addSubview(titlelabel)
        contentView.addSubview(versionLabel)
    }

    private func setupConstraints() {
        titlelabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(versionLabel.snp.leading)
        }
        
        versionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
