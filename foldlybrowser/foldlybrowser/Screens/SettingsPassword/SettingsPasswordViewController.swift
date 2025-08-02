//
//  SettingsPasswordViewController.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

typealias SettingPasswordCell = SettingSwitchedCell

protocol SettingsPasswordViewControllerProtocol: AnyObject {
    func render(_ data: SettingsPasswordProps)
}

final class SettingsPasswordViewController: UITableViewController, SettingsPasswordViewControllerProtocol {

    // MARK: - Properties
    private(set) var settingsPasswordData: SettingsPasswordProps?
    var presenter: SettingsPasswordPresenterProtocol!
    
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

    // MARK: - SettingsPasswordViewControllerProtocol
    func render(_ data: SettingsPasswordProps) {
        settingsPasswordData = data
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension SettingsPasswordViewController {

    func setupView() {
        setupNavigationBar()

        view.backgroundColor = .lightgray
        tableView.do {
            $0.backgroundColor = .lightgray
            $0.contentInset.top = 30
            $0.showsVerticalScrollIndicator = false
            $0.allowsMultipleSelection = false
            $0.register(cellWithClass: SettingPasswordCell.self)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = .init(localized: "settings.password.navigationTitle")
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .lightgray
        appearance.backgroundEffect = UIBlurEffect(style: .dark)
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - UITableViewDataSource
extension SettingsPasswordViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        settingsPasswordData?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsPasswordData?.sections[section].items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = settingsPasswordData?.sections[indexPath.section] else {
            return UITableViewCell()
        }

        switch section.items[indexPath.row] {
        case .settingPasswordCell(let data):
            let cell = tableView.dequeueCell(withClass: SettingPasswordCell.self, for: indexPath)
            cell.render(data)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settingsPasswordData?.sections[section].sectionTitle
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        settingsPasswordData?.sections[section].sectionDesctiption
    }
}

// MARK: - UITableViewDelegate
extension SettingsPasswordViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let rowType = settingsPasswordData?.sections[indexPath.section].items[indexPath.row] else { return }

        switch rowType {
        case .settingPasswordCell(let data):
            break
        }
    }
}
