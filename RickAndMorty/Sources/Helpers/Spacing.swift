//
//  Spacing.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 17.01.2025.
//

import Foundation
import CoreGraphics
import SwiftUI

/// Consistent spacing makes an interface more clear and easy to scan.
///
/// Spacing is based on a 4-pixel grid.
///
@MainActor
public struct Spacing: AppearanceType {
    public let value: CGFloat

    nonisolated public init(value: CGFloat) {
        self.value = value
    }

    /// 0 pts.
    public static var zero: Spacing = 0
    /// 2 pts.
    public static var _025: Spacing = 2
    /// 4 pts.
    public static var _05: Spacing = 4
    /// 8 pts.
    public static var _1: Spacing = 8
    /// 12 pts.
    public static var _15: Spacing = 12
    /// 16 pts.
    public static var _2: Spacing = 16
    /// 24 pts.
    public static var _3: Spacing = 24
    /// 32 pts.
    public static var _4: Spacing = 32
    /// 40 pts.
    public static var _5: Spacing = 40
    /// 48 pts.
    public static var _6: Spacing = 48
    /// 56 pts.
    public static var _7: Spacing = 56
    /// 64 pts.
    public static var _8: Spacing = 64
    /// 72 pts.
    public static var _9: Spacing = 72
    /// 80 pts.
    public static var _10: Spacing = 80

    public static let infinity: Spacing = .init(value: .infinity)
}

public extension View {
    @MainActor
    func padding(_ value: Spacing) -> some View {
        padding(value.value)
    }

    @MainActor
    func padding(_ edges: Edge.Set, _ value: Spacing) -> some View {
        padding(edges, value.value)
    }

    @MainActor
    @_disfavoredOverload
    func frame(width: Spacing? = nil, height: Spacing? = nil, alignment: SwiftUI.Alignment = .center) -> some View {
        frame(width: width?.value, height: height?.value, alignment: alignment)
    }

    @MainActor
    @_disfavoredOverload
    func frame(
        minWidth: Spacing? = nil,
        idealWidth: Spacing? = nil,
        maxWidth: Spacing? = nil,
        minHeight: Spacing? = nil,
        idealHeight: Spacing? = nil,
        maxHeight: Spacing? = nil,
        alignment: Alignment = .center
    ) -> some View {
        self.frame(
            minWidth: minWidth?.value,
            idealWidth: idealWidth?.value,
            maxWidth: maxWidth?.value,
            minHeight: minHeight?.value,
            idealHeight: idealHeight?.value,
            maxHeight: maxHeight?.value,
            alignment: alignment
        )
    }
}

public extension VStack {
    @MainActor
    init(alignment: HorizontalAlignment = .center, spacing: Spacing, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, content: content)
    }
}

public extension LazyVStack {
    @MainActor
    init(alignment: HorizontalAlignment = .center, spacing: Spacing, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, pinnedViews: pinnedViews, content: content)
    }
}

public extension HStack {
    @MainActor
    init(alignment: VerticalAlignment = .center, spacing: Spacing, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, content: content)
    }
}

public extension LazyHStack {
    @MainActor
    init(alignment: VerticalAlignment = .center, spacing: Spacing, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, content: content)
    }
}

public extension LazyVGrid {
    @MainActor
    init(columns: [GridItem], alignment: HorizontalAlignment = .center, spacing: Spacing, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) {
        self.init(columns: columns, alignment: alignment, spacing: spacing.value, pinnedViews: pinnedViews, content: content)
    }
}

public extension LazyHGrid {
    @MainActor
    init(rows: [GridItem], alignment: VerticalAlignment = .center, spacing: Spacing, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) {
        self.init(rows: rows, alignment: alignment, spacing: spacing.value, pinnedViews: pinnedViews, content: content)
    }
}

public extension EdgeInsets {
    static var zero: EdgeInsets {
        EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
}
