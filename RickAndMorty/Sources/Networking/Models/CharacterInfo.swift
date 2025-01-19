//
//  CharacterInfo.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import Foundation

enum CharacterInfo: Hashable {
    case status(String)
    case species(String)
    case type(String)
    case gender(String)
    case origin(String)
    case location(String)

    static func all(for character: Character) -> [CharacterInfo] {
        return [
            .status(character.status),
            .species(character.species),
            .type(character.type.isEmpty ? "-" : character.type),
            .gender(character.gender),
            .origin(character.origin.name),
            .location(character.location.name)
        ]
    }

    var label: String {
        switch self {
        case .status: return "Status"
        case .species: return "Species"
        case .type: return "Type"
        case .gender: return "Gender"
        case .origin: return "Origin"
        case .location: return "Location"
        }
    }

    var value: String {
        switch self {
        case .status(let value),
                .species(let value),
                .type(let value),
                .gender(let value),
                .origin(let value),
                .location(let value):
            return value
        }
    }
}
