//
//  APIError.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidUrlComponents
    case noResponse
    case unacceptableResponseStatusCode
    case customDecodingFailed
    case malformedUrl
}
