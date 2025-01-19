//
//  Character.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let imageUrl: URL
    let episodeUrls: [URL]
    let url: URL
    let created: String // Date()

    var episodeIds: [Int] {
        episodeUrls
            .compactMap {
                Int($0.lastPathComponent)
            }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case imageUrl = "image"
        case episodeUrls = "episode"
        case url
        case created
    }
}

// MARK: - Conformances
extension Character: Identifiable {}
extension Character: Equatable {}

// MARK: - Mock
#if DEBUG
extension Character {
    static let mock: Character = .init(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .mock,
        location: .mock,
        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        episodeUrls: [
            URL(string: "https://rickandmortyapi.com/api/episode/1")!,
            URL(string: "https://rickandmortyapi.com/api/episode/2")!
        ],
        url: URL(string: "https://rickandmortyapi.com/api/character/2")!,
        created: Date().formatted()
    )

    static let mockArray: [Character] = {
        (0 ... 20).map {
            Character(
                id: $0,
                name: "Rick Sanchez - \($0)",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: .mock,
                location: .mock,
                imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/\($0 + 1).jpeg")!,
                episodeUrls: [
                    URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                    URL(string: "https://rickandmortyapi.com/api/episode/2")!
                ],
                url: URL(string: "https://rickandmortyapi.com/api/character/2")!,
                created: Date().addingTimeInterval(Double($0) + 1).formatted()
            )
        }
    }()
}
#endif
