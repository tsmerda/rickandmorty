//
//  CornerRadius.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import SwiftUI

@MainActor
public struct CornerRadius: AppearanceType {
    public let value: CGFloat

    nonisolated public init(value: CGFloat) {
        self.value = value
    }

    /// value: 0
    @MainActor
    public static var zero: CornerRadius = 0
    /// value: 4
    @MainActor
    public static var xxSmall: CornerRadius = 4
    /// value: 8
    @MainActor
    public static var xSmall: CornerRadius = 8
    /// value: 12
    @MainActor
    public static var small: CornerRadius = 12
    /// value: 16
    @MainActor
    public static var medium: CornerRadius = 16
    /// value: 24
    @MainActor
    public static var large: CornerRadius = 24
    /// value: 32.0
    @MainActor
    public static var xLarge: CornerRadius = 32
    /// value: 40.0
    @MainActor
    public static var xxLarge: CornerRadius = 40

    @MainActor
    public static var round: CornerRadius = .init(value: .greatestFiniteMagnitude)
}

public extension RoundedRectangle {
    @MainActor
    init(cornerRadius: CornerRadius, style: RoundedCornerStyle = .continuous) {
        self.init(cornerRadius: cornerRadius.value, style: style)
    }
}

public extension View {
    @MainActor
    func cornerRadius(_ radius: CornerRadius, antialiased: Bool = true) -> some View {
        cornerRadius(radius.value, antialiased: antialiased)
    }
}
