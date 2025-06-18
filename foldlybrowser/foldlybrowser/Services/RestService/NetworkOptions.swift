//
//  NetworkOptions.swift
//  Reserve
//
//  Created by m.TapticGroup on 27.03.2025.
//

import Foundation

struct NetworkOptions {
    var token: String?

    init(options: [Options]) {
        for option in options {
            switch option {
            case .tokenRequirement(let token):
                self.token = token
            }
        }
    }

    enum Options {
        case tokenRequirement(String)
    }
}
