//
//  WepageProps.swift
//  foldlybrowser
//
//  Created by TapticGroup on 03/08/2025.
//

import Foundation

enum SearchEngine: String, Codable {
    case google
    case duckduckgo
    case bing
    case yandex

    var baseURL: String {
        switch self {
        case .google:      return "https://www.google.com/search?q="
        case .duckduckgo:  return "https://duckduckgo.com/?q="
        case .bing:        return "https://www.bing.com/search?q="
        case .yandex:       return "https://yandex.ru/search/?text="
        }
    }
    
    var name : String {
        switch self {
        case .google:
            return "Google"
        case .bing:
            return "Bing"
        case .duckduckgo:
            return "Duck Duck Go"
        case .yandex:
            return "Yandex"
        }
    }
    
    var iconName : String {
        switch self {
        case .google:
            return "google-s-engine-icon"
        case .bing:
            return "bing-s-engine-icon"
        case .duckduckgo:
            return "duck-s-engine-icon"
        case .yandex:
            return "yandex-s-engine-icon"
        }
    }
}
