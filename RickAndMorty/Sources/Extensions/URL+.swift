//
//  URL+.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

extension URL {
    func valueOf(queryParameter: String) -> String? {
        guard let url = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        return url.queryItems?
            .first { $0.name == queryParameter }?
            .value
    }
}
