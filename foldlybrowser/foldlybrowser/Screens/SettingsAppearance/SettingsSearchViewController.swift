//
//  SettingsSearchEngineViewController.swift
//  foldlybrowser
//
//  Created by Karpinskii.D.S. on 26.07.2025.
//

import UIKit

protocol SettingsSearchEngineViewControllerProtocol: AnyObject {
    func render(_ data: SettingsSearchEngineProps)
}

final class SettingsSearchEngineViewController: UITableViewController, SettingsSearchEngineViewControllerProtocol {

    // MARK: - Properties
    private(set) var settingsSearchEngineData: SettingsSearchEngineProps?
    var presenter: SettingsSearchEnginePresenterProtocol!
    
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

    // MARK: - SettingsSearchEngineViewControllerProtocol
    func render(_ data: SettingsSearchEngineProps) {
        settingsSearchEngineData = data
        tableView.reloadData()
    }
}

// MARK: - Private Methods
private extension SettingsSearchEngineViewController {

    func setupView() {
        setupNavigationBar()

        view.backgroundColor = .lightgray
        tableView.do {
            $0.backgroundColor = .lightgray
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.allowsMultipleSelection = false
            $0.register(cellWithClass: SettingSwitchedCell.self)
            $0.register(cellWithClass: SettingSearchEngineCell.self)
        }
    }

    func setupNavigationBar() {
        navigationItem.title = .init(localized: "settings.searchEngine.navigationTitle")
        
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
extension SettingsSearchEngineViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        settingsSearchEngineData?.sections.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsSearchEngineData?.sections[section].items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = settingsSearchEngineData?.sections[indexPath.section] else {
            return UITableViewCell()
        }

        switch section.items[indexPath.row] {
        case .automatic(let data):
            let cell = tableView.dequeueCell(withClass: SettingSwitchedCell.self, for: indexPath)
            cell.render(data)
            return cell
        case .searchEngine(let data):
            let cell = tableView.dequeueCell(withClass: SettingSearchEngineCell.self, for: indexPath)
            cell.render(data, userSelectedSearchEngine: presenter.searchEngine)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settingsSearchEngineData?.sections[section].sectionTitle
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        settingsSearchEngineData?.sections[section].sectionDesctiption
    }
}

// MARK: - UITableViewDelegate
extension SettingsSearchEngineViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let rowType = settingsSearchEngineData?.sections[indexPath.section].items[indexPath.row] else { return }

        if case .searchEngine(let data) = rowType {
            presenter.searchEngine = data.searchEngine
            
            tableView.visibleCells.forEach { cell in
                if let searchCell = cell as? SettingSearchEngineCell,
                   let cellIndexPath = tableView.indexPath(for: searchCell),
                   case .searchEngine(let item) = settingsSearchEngineData?.sections[cellIndexPath.section].items[cellIndexPath.row] {
                    searchCell.setChecked(item.searchEngine == presenter.searchEngine)
                }
            }
        }
    }
}
