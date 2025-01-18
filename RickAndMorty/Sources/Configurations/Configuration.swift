//
//  Configuration.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

struct Configuration: Decodable {
    private enum CodingKeys: String, CodingKey {
        case apiBaseUrl = "https://rickandmortyapi.com/api/"
    }

    let apiBaseUrl: URL
}

extension Configuration {
    static let `default`: Configuration = {
        guard let propertyList = Bundle.main.infoDictionary else {
            fatalError("Unable to get property list.")
        }

        guard let data = try? JSONSerialization.data(withJSONObject: propertyList, options: []) else {
            fatalError("Unable to instantiate data from property list.")
        }

        let decoder = JSONDecoder()

        guard let configuration = try? decoder.decode(Configuration.self, from: data) else {
            fatalError("Unable to decode the Environment configuration file.")
        }

        return configuration
    }()
}
