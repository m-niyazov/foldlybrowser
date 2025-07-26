//
//  SettingsViewController.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    func render(_ data: SettingsProps)
}

final class SettingsViewController: UITableViewController, SettingsViewControllerProtocol {

    // MARK: - Properties
    private(set) var settingsData: SettingsProps?
    var presenter: SettingsPresenterProtocol!
    
    // MARK: - Init
       init() {
           super.init(style: .insetGrouped)
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData()
        setupView()
    }

    // MARK: - SettingsViewControllerProtocol
    func render(_ data: SettingsProps) {
        settingsData = data
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension SettingsViewController {

    func setupView() {
        setupNavigationBar()

        view.backgroundColor = .lightgray1
        tableView.do {
            $0.backgroundColor = .lightgray1
            $0.contentInset.top = 30
            $0.showsVerticalScrollIndicator = false
            $0.allowsMultipleSelection = false
            $0.register(cellWithClass: SettingCell.self)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = .init(localized: "settings.navigationTitle")
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .lightgray1
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        settingsData?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsData?.sections[section].items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = settingsData?.sections[indexPath.section] else {
            return UITableViewCell()
        }

        switch section.items[indexPath.row] {
        case .settingCell(let data):
            let cell = tableView.dequeueCell(withClass: SettingCell.self, for: indexPath)
            cell.render(data)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settingsData?.sections[section].sectionTitle
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        settingsData?.sections[section].sectionDesctiption
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
