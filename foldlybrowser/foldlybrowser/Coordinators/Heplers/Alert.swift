//
//  Alert.swift
//  absurdino
//  absurdino
//
//  Created by Niyazov on 20.11.2022.
//

import UIKit

struct Alert {
    let title: String?
    let message: String?
    let style: UIAlertController.Style
    let actions: [Action]

    struct Action {
        let title: String
        let style: UIAlertAction.Style
        let action: (() -> Void)?
    }
}
