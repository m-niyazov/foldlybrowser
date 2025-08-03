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
    // расширяй при необходимости

    var baseURL: String {
        switch self {
        case .google:      return "https://www.google.com/search?q="
        case .duckduckgo:  return "https://duckduckgo.com/?q="
        case .bing:        return "https://www.bing.com/search?q="
        case .yandex:       return "https://yandex.ru/search/?text="
        }
    }
}
