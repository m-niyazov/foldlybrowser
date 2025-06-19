//
//  UITableViewCell+Extension .swift
//  foldlybrowser
//
//  Created by Niyazov on 17.06.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
