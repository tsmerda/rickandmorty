//
//  PaginatedResponse.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let info: PaginationInfo
    let results: [T]
}
