import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }

    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }

    func dequeueCell<T: UICollectionViewCell>(with indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: String(describing: T.self),
            for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell")
        }
        return cell
    }

    func dequeueSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: T.self),
            for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView")
        }
        return cell
    }
}

extension UICollectionView {
    /// Last Section of the CollectionView
    var lastSection: Int {
        return numberOfSections - 1
    }

    /// IndexPath of the last item in last section.
    var lastIndexPath: IndexPath? {
        guard lastSection >= 0 else {
            return nil
        }

        let lastItem = numberOfItems(inSection: lastSection) - 1
        guard lastItem >= 0 else {
            return nil
        }

        return IndexPath(item: lastItem, section: lastSection)
    }

    /// Islands: Scroll to bottom of the CollectionView
    /// by scrolling to the last item in CollectionView
    func scrollToBottom(animated: Bool) {
        guard let lastIndexPath = lastIndexPath else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.scrollToItem(at: lastIndexPath, at: .bottom, animated: animated)
        }
    }
}
