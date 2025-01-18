//
//  AppearanceType.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

public protocol AppearanceType: Sendable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral where FloatLiteralType == Double, IntegerLiteralType == Int {
    var value: CGFloat { get }

    init(value: CGFloat)
}

public extension AppearanceType {
    init(floatLiteral value: Double) {
        let value = CGFloat(value)
        self.init(value: value)
    }

    init(integerLiteral value: IntegerLiteralType) {
        self.init(value: CGFloat(value))
    }

    static func +(lhs: Self, rhs: Self) -> Self {
        return .init(value: lhs.value + rhs.value)
     }
}
