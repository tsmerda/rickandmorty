//
//  HTTPHeader.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

enum HTTPHeader {
    enum HeaderField: String {
        case contentType = "Content-Type"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case text = "text/html;charset=utf-8"
    }
}
