//
//  APIManaging.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

protocol APIManaging {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
