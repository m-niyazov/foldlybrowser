//
//  SettingsAboutAppViewController.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

typealias SettingsAppVersionCell = SettingCell

protocol SettingsAboutAppViewControllerProtocol: AnyObject {
    func render(_ data: SettingsAboutAppProps)
}

final class SettingsAboutAppViewController: UITableViewController, SettingsAboutAppViewControllerProtocol {

    // MARK: - Properties
    private(set) var settingsAboutAppData: SettingsAboutAppProps?
    var presenter: SettingsAboutAppPresenterProtocol!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - SettingsAboutAppViewControllerProtocol
    func render(_ data: SettingsAboutAppProps) {
        settingsAboutAppData = data
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension SettingsAboutAppViewController {

    func setupView() {
        setupNavigationBar()

        view.backgroundColor = .lightgray
        tableView.do {
            $0.backgroundColor = .lightgray
            $0.allowsMultipleSelection = false
            $0.isScrollEnabled = false
            $0.register(cellWithClass: SettingVersionCell.self)
            $0.register(cellWithClass: SettingsAppVersionCell.self)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = .init(localized: "settings.aboutApp.navigationTitle")

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
extension SettingsAboutAppViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        settingsAboutAppData?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsAboutAppData?.sections[section].items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = settingsAboutAppData?.sections[indexPath.section] else {
            return UITableViewCell()
        }

        switch section.items[indexPath.row] {
        case .version(let data):
            let cell = tableView.dequeueCell(withClass: SettingVersionCell.self, for: indexPath)
            cell.render(data)
            return cell
        case .link(let data):
            let cell = tableView.dequeueCell(withClass: SettingsAppVersionCell.self, for: indexPath)
            cell.render(data)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settingsAboutAppData?.sections[section].sectionTitle
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        settingsAboutAppData?.sections[section].sectionDesctiption
    }
}

// MARK: - UITableViewDelegate
extension SettingsAboutAppViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let rowType = settingsAboutAppData?.sections[indexPath.section].items[indexPath.row] else { return }

        switch rowType {
        case .link(let data):
            data.select()
        case .version(_):
            break
        }
    }
}
