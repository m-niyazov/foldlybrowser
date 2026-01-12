//
//  FaviconFetcher.swift
//  foldlybrowser
//
//  Created by TapticGroup on 24/08/2025.
//

import Foundation
import UIKit

struct FaviconFetcher {

    static func fetchIcon(for url: URL) async -> UIImage? {
        if let base = url.host,
           let appleTouchURL = URL(string: "https://\(base)/apple-touch-icon.png"),
           let icon = try? await downloadImage(from: appleTouchURL) {
            return icon
        }

        if let html = try? await downloadHTML(from: url) {
            let icons = parseAppleTouchIcons(from: html, baseURL: url)
            for iconURL in icons {
                if let img = try? await downloadImage(from: iconURL) {
                    return img
                }
            }
        }

        // 4. Фоллбек
        if let base = url.host {
            let fallbacks = [
                "https://\(base)/favicon-180x180.png",
                "https://\(base)/favicon.png",
                "https://\(base)/favicon.ico"
            ]

            for urlStr in fallbacks {
                if let fURL = URL(string: urlStr),
                   let icon = try? await downloadImage(from: fURL) {
                    if urlStr == "https://www.google.com/favicon.ico" {
                        return .googleSEngineIcon
                    } else {
                        return icon
                    }
                }
            }
        }

        return nil
    }

    private static func downloadImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200,
              let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        return image
    }

    private static func downloadHTML(from url: URL) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(decoding: data, as: UTF8.self)
    }

    private static func parseAppleTouchIcons(from html: String, baseURL: URL) -> [URL] {
        var results: [(Int, URL)] = []

        let pattern = #"<link[^>]+rel=["']apple-touch-icon[^"']*["'][^>]*>"#
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)

        for match in regex.matches(in: html, range: NSRange(html.startIndex..., in: html)) {
            let tag = (html as NSString).substring(with: match.range)

            // href
            let hrefRegex = try! NSRegularExpression(pattern: #"href=["']([^"']+)["']"#)
            guard let hMatch = hrefRegex.firstMatch(in: tag, range: NSRange(tag.startIndex..., in: tag)) else { continue }
            let href = (tag as NSString).substring(with: hMatch.range(at: 1))
            guard let url = URL(string: href, relativeTo: baseURL) else { continue }

            // sizes
            let sizesRegex = try! NSRegularExpression(pattern: #"sizes=["'](\d+)x(\d+)["']"#)
            var size = 0
            if let sMatch = sizesRegex.firstMatch(in: tag, range: NSRange(tag.startIndex..., in: tag)) {
                let w = Int((tag as NSString).substring(with: sMatch.range(at: 1))) ?? 0
                let h = Int((tag as NSString).substring(with: sMatch.range(at: 2))) ?? 0
                size = max(w, h)
            }

            results.append((size, url))
        }

        // сортировка по размеру (сначала самые большие)
        return results.sorted { $0.0 > $1.0 }.map { $0.1 }
    }

}
