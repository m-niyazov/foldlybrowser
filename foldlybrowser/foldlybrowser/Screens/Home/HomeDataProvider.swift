//
//  HomeDataProvider.swift
//  foldlybrowser
//
//  Created by TapticGroup on 21/06/2025.
//

import Foundation
import UIKit

final class ExploreViewDataProvider: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var props: HomeProps?

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return props?.sections.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let props = self.props else {
            return 0
        }
        switch props.sections[section].type {
        case .header:
            return 1
        case .sectionTitle:
            return 1
        case .searchTrends:
            return 1
        case .folders(let folderProps):
            return folderProps.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let props = self.props else {
            return UICollectionViewCell()
        }
        switch props.sections[indexPath.section].type {
        case .header(let headerProps):
            let cell = collectionView.dequeueCell(with: indexPath) as HomeHeaderCell
            cell.render(headerProps)
            return cell
        case .searchTrends:
            let cell = collectionView.dequeueCell(with: indexPath) as HomeSearchTrendsCell
            return cell
        case .sectionTitle(let sectionTitle):
            let cell = collectionView.dequeueCell(with: indexPath) as HomeSectionTitleCell
            cell.render(sectionTitle)
            return cell
        case .folders(let folderProps):
            let cell = collectionView.dequeueCell(with: indexPath) as HomeFolderViewCell
            cell.render(folderProps[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let props = self.props else {
            return
        }
        let sectionType = props.sections[indexPath.section].type
        let cell = collectionView.cellForItem(at: indexPath)

    }


    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let props = self.props else {
            return
        }
        let sectionType = props.sections[indexPath.section].type
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let props = self.props else {
            return
        }
        let sectionType = props.sections[indexPath.section].type
    }
}
