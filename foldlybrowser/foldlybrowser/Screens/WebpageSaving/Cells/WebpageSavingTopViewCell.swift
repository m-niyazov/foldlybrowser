//
//  WebpageSavingTopCellTableViewCell.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import UIKit

class WebpageSavingTopViewCell: UITableViewCell, UITextFieldDelegate {

    // MARK: - Views
    private let mainStackView = UIStackView()
    private let trailingStackView = UIStackView()
    private let iconImageViewContainer = UIView()
    private let iconImageView = UIImageView()
    let titleTextField = UITextField()
    private let horizonatalDecoratorLineView = UIView()
    private let urlLabel = UILabel()

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
    func render(image: UIImage, title: String, url: String) {
        iconImageView.image = image
        titleTextField.text = title
        urlLabel.text = url
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    // MARK: - Private Setup
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .white

        iconImageView.do {
            $0.contentMode = .scaleAspectFit
        }

        mainStackView.do {
            $0.spacing = 15
        }

        titleTextField.do {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.clearButtonMode = .whileEditing
            $0.delegate = self
            $0.placeholder = "Title"
        }

        urlLabel.do {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }

        horizonatalDecoratorLineView.do {
            $0.backgroundColor = .systemGray5
        }

        trailingStackView.do {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.isLayoutMarginsRelativeArrangement = true
        }
    }

    private func setupLayout() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(iconImageViewContainer)
        iconImageViewContainer.addSubview(iconImageView)
        mainStackView.addArrangedSubview(trailingStackView)
        trailingStackView.addArrangedSubview(titleTextField)
        trailingStackView.addArrangedSubview(horizonatalDecoratorLineView)
        trailingStackView.addArrangedSubview(urlLabel)

        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageViewContainer.snp.makeConstraints {
            $0.size.equalTo(100)
        }

        iconImageView.snp.makeConstraints {
            $0.size.lessThanOrEqualToSuperview()
            $0.center.equalToSuperview()
        }

        [titleTextField, urlLabel].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }

        horizonatalDecoratorLineView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }

}
