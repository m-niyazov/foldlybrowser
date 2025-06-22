//
//  HomeView.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Properties

    private var props: HomeProps?
    private let dataProvider = ExploreViewDataProvider()

    // MARK: - Views

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    
    // MARK: - Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func render(_ props: HomeProps) {
        self.props = props
        dataProvider.props = props
        collectionView.reloadData()
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.collectionView.alpha = 1
            self.collectionView.transform = .identity
        }
    }

    func update(_ props: HomeProps) {
        self.props = props
        dataProvider.props = props
        collectionView.reloadData()
    }
}

private extension HomeView {
    func setupView() {
        self.do {
            $0.backgroundColor = .none
        }

        collectionView.do {
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            $0.backgroundColor = .none
            $0.dataSource = dataProvider
            $0.delegate = dataProvider
            $0.alpha = 0
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            $0.register(cellWithClass: HomeHeaderCell.self)
            $0.register(cellWithClass: HomeSearchTrendsCell.self)
            $0.register(cellWithClass: HomeSectionTitleCell.self)
            $0.register(cellWithClass: HomeFolderViewCell.self)
        }
    }

    func addSubviews() {
        addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let section = self.props?.sections[sectionIndex] else {
                return nil
            }

            switch section.type {
            case .header:
                return self.createHeaderLayoutSection()
            case .sectionTitle:
                return self.createSectionTitleLayoutSection()
            case .searchTrends:
                return self.createSearchTrendsSection()
            case .folders:
                return self.сreateFoldersSection()
            }
        }
        layout.register(HomeSectionBackgroundView.self, forDecorationViewOfKind: HomeSectionBackgroundView.kind)
        return layout
    }

    func createHeaderLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0), // Ширина равна ширине группы
                heightDimension: .estimated(1) // Динамическая высота
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0), // Ширина равна ширине коллекции
                heightDimension: .estimated(1) // Динамическая высота
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return section
    }

    func createSearchTrendsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(UIScreen.main.bounds.height * 0.18)
            ))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(UIScreen.main.bounds.height * 0.18)
            ),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 16, bottom: 0, trailing: 16)
        return section
    }

    func createSectionTitleLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0), // Ширина равна ширине группы
                heightDimension: .estimated(1) // Динамическая высота
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0), // Ширина равна ширине коллекции
                heightDimension: .estimated(1) // Динамическая высота
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 16, bottom: 0, trailing: 16)
        return section
    }

    func сreateFoldersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                             heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
     //   group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 28, leading: 32, bottom: 24, trailing: 32)
    //    let layout = UICollectionViewCompositionalLayout(section: section)
        let bg = NSCollectionLayoutDecorationItem.background(
                           elementKind: HomeSectionBackgroundView.kind)
              bg.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16,
                                                         bottom: 16, trailing: 16)
        section.decorationItems = [bg]
        return section
    }

}
