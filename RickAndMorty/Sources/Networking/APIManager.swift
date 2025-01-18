//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation
import Factory

protocol APIManagerType {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

final class APIManager: APIManagerType {
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        
        return URLSession(configuration: config)
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }()
    
    private func request(_ endpoint: Endpoint) async throws -> Data {
        let request: URLRequest = try endpoint.asRequest()
        
        Logger.log("🚀 Request for \"\(request.description)\"")
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unacceptableResponseStatusCode
        }
        
        if let body = String(data: data, encoding: .utf8) {
            Logger.log("""
            ☀️ Response for \"\(request.description)\":
            👀 Status: \(httpResponse.statusCode)
            🧍‍♂️ Body:
            \(body)
            """)
        }
        
        return data
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await request(endpoint)
        let object = try decoder.decode(T.self, from: data)
        
        return object
    }
}

extension Container {
    var apiManager: Factory<APIManagerType> {
        self { APIManager() }
            .singleton
    }
}
