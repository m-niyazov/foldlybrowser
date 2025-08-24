// 
//  WebpageSavingViewController.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import UIKit

protocol WebpageSavingViewControllerProtocol: AnyObject {
    func render(url: String, title: String)
    func setFavicon(image: UIImage)
}

final class WebpageSavingViewController: UIViewController, WebpageSavingViewControllerProtocol {
    // MARK: - Properties
    
    // swiftlint:disable implicitly_unwrapped_optional
    var presenter: WebpageSavingPresenterProtocol!
    // swiftlint:enable implicitly_unwrapped_optional
    private var webPageUrl = String()
    private var webPageTitle = String()
    private var webPageFavicon = UIImage()

    // MARK: - Views
    let tableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData()
        setupView()
        addViews()
        setupConstraints()
    }
    
    // MARK: - Methods
    func render(url: String, title: String) {
        self.webPageUrl = url
        self.webPageTitle = title
        tableView.reloadData()
    }

    func setFavicon(image: UIImage) {
        self.webPageFavicon = image
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - Private Methods

private extension WebpageSavingViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Add to Favorites"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(handleCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(handleSave)
        )

        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = true
            $0.addGestureRecognizer(tapGesture)
            $0.register(cellWithClass: WebpageSavingTopViewCell.self)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    func addViews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func handleSave() {
        let cell = tableView.cellForRow(at: .init(row: 0, section: 0)) as?  WebpageSavingTopViewCell
        print(cell?.titleTextField.text)
    }

    @objc func handleCancel() {

    }
}

extension WebpageSavingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Location" : nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueCell(withClass: WebpageSavingTopViewCell.self, for: indexPath)
            cell.render(image: webPageFavicon, title: webPageTitle, url: webPageUrl)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell")
                ?? UITableViewCell(style: .default, reuseIdentifier: "LocationCell")
            cell.textLabel?.text = "Favorites"
            cell.imageView?.image = UIImage(systemName: "star")
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}
