//
//  KeyRepresentable.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import Foundation

public protocol KeyRepresentable: Hashable {
    associatedtype KeyValue
    var keyValue: KeyValue { get }
}

public extension KeyRepresentable where Self: RawRepresentable, Self.RawValue == KeyValue {
    var keyValue: KeyValue { rawValue }
}

extension String: KeyRepresentable {
    public var keyValue: String { self }
}
