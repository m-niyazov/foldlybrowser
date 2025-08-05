//
//  SearchURLBuilder.swift
//  foldlybrowser
//
//  Created by TapticGroup on 03/08/2025.
//

import Foundation

struct SearchURLBuilder {
    /// Преобразует ввод (например, "apple.com" или "how to cook") в URL
    static func buildURL(from input: String, using engine: SearchEngine) -> URL {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if let direct = URL(string: trimmed),
           (direct.scheme == "http" || direct.scheme == "https")
            || (direct.host != nil && trimmed.contains("."))
        {
            return direct
        }
        let q = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? trimmed
        return URL(string: engine.baseURL + q)!
    }

    /// Доменная часть или полный URL (для не-поисковиков)
    static func displayNonEditing(_ url: URL) -> String {
        return url.host ?? url.absoluteString
    }

    /// При редактировании: если это поисковая ссылка — вернёт только query, иначе — full URL
    static func displayEditing(_ url: URL, engine: SearchEngine) -> String {
//        guard let host = url.host else {
//            return url.absoluteString
//        }
        // если URL соответствует текущему поисковику — вытянем query
//        if host.contains(engine.rawValue) {
//            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
//            let qname = engine == .yandex ? "text" : "q"
//            return components?.queryItems?.first(where: { $0.name == qname })?.value
//                   ?? ""
//        }
        return url.absoluteString
    }
}
