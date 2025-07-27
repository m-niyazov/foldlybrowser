//
//  SettingsAppearanceViewController.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

protocol SettingsAppearanceViewControllerProtocol: AnyObject {
    func render(_ data: SettingsAppearanceProps)
}

final class SettingsAppearanceViewController: UITableViewController, SettingsAppearanceViewControllerProtocol {

    // MARK: - Properties
    private(set) var settingsAppearanceData: SettingsAppearanceProps?
    var presenter: SettingsAppearancePresenterProtocol!
    
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

    // MARK: - SettingsAppearanceViewControllerProtocol
    func render(_ data: SettingsAppearanceProps) {
        settingsAppearanceData = data
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension SettingsAppearanceViewController {

    func setupView() {
        setupNavigationBar()

        view.backgroundColor = .lightgray1
        tableView.do {
            $0.backgroundColor = .lightgray1
            $0.contentInset.top = 30
            $0.showsVerticalScrollIndicator = false
            $0.allowsMultipleSelection = false
            $0.register(cellWithClass: SettingThemeCell.self)
            $0.register(cellWithClass: SettingColorsCell.self)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = .init(localized: "settings.appearance.navigationTitle")
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
extension SettingsAppearanceViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        settingsAppearanceData?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsAppearanceData?.sections[section].items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = settingsAppearanceData?.sections[indexPath.section] else {
            return UITableViewCell()
        }

        switch section.items[indexPath.row] {
        case .appearance(let data):
            let cell = tableView.dequeueCell(withClass: SettingThemeCell.self, for: indexPath)
            cell.render(data)
            return cell
        case .color(let data):
            let cell = tableView.dequeueCell(withClass: SettingColorsCell.self, for: indexPath)
            cell.render(data, userSelectedColor: presenter.userSelectedColor)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settingsAppearanceData?.sections[section].sectionTitle
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        settingsAppearanceData?.sections[section].sectionDesctiption
    }
}

// MARK: - UITableViewDelegate
extension SettingsAppearanceViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let rowType = settingsAppearanceData?.sections[indexPath.section].items[indexPath.row] else { return }

        switch rowType {
        case .appearance(let data):
            data.select()

        case .color(let data):
            presenter.userSelectedColor = data.color
            data.select()

            for cell in tableView.visibleCells {
                if let colorCell = cell as? SettingColorsCell,
                   let indexPath = tableView.indexPath(for: colorCell),
                   case let .color(item) = settingsAppearanceData?.sections[indexPath.section].items[indexPath.row] {
                    colorCell.setChecked(item.color == presenter.userSelectedColor)
                }
            }
        }
    }
}
