//
//  CharactersRouter.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

enum CharactersRouter {
    case getCharacters(page: Int?)
}

extension CharactersRouter: Endpoint {
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        case let .getCharacters(.some(page)):
            return ["page": page]
        case .getCharacters:
            return nil
        }
    }
}
