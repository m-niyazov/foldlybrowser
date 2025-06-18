//
//  TargetType.swift
//  ProSport
//
//  Created by m.TapticGroup on 27.03.2025.
//

import Moya
import Foundation

extension TargetType {
    var baseURL: URL {
        URL(string: "Default api url")!
    }

    var sampleData: Data {
        Data()
    }

    var headers: [String: String]? {
        nil
    }

    var validationType: ValidationType {
        .successCodes
    }
}
