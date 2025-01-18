//
//  TextStyle.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 17.01.2025.
//

import SwiftUI

struct TextStyle {
    let size: CGFloat
    let lineHeight: CGFloat
    let letterSpacing: CGFloat
    let fontWeight: Font.Weight
    let relativeTextStyle: Font.TextStyle
}

extension TextStyle {
    static let headline1 = TextStyle(
        size: 28,
        lineHeight: 34,
        letterSpacing: 0,
        fontWeight: .bold,
        relativeTextStyle: .headline
    )

    static let headline2 = TextStyle(
        size: 20,
        lineHeight: 24,
        letterSpacing: 0,
        fontWeight: .bold,
        relativeTextStyle: .headline
    )

    static let headline3 = TextStyle(
        size: 16,
        lineHeight: 20,
        letterSpacing: 0,
        fontWeight: .bold,
        relativeTextStyle: .headline
    )

    static let paragraphLarge = TextStyle(
        size: 18,
        lineHeight: 22,
        letterSpacing: 0,
        fontWeight: .regular,
        relativeTextStyle: .body
    )

    static let paragraphMedium = TextStyle(
        size: 16,
        lineHeight: 20,
        letterSpacing: 0,
        fontWeight: .regular,
        relativeTextStyle: .body
    )

    static let paragraphSmall = TextStyle(
        size: 14,
        lineHeight: 18,
        letterSpacing: 0,
        fontWeight: .regular,
        relativeTextStyle: .body
    )

    static let bottomNavigation = TextStyle(
        size: 12,
        lineHeight: 14,
        letterSpacing: 0,
        fontWeight: .regular,
        relativeTextStyle: .caption
    )
}

extension View {
    func textStyle(_ textStyle: TextStyle, isUppercased: Bool = false) -> some View {
        self
            .font(.system(size: textStyle.size, weight: textStyle.fontWeight))
            .lineSpacing(textStyle.lineHeight - textStyle.size)
            .padding(.vertical, (textStyle.lineHeight - textStyle.size) / 2)
            .kerning(textStyle.letterSpacing)
            .textCase(isUppercased ? .uppercase : nil)
    }
}

private struct TextStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: TextStyle = TextStyle.headline1
}

extension EnvironmentValues {
    var textStyle: TextStyle {
        get { self[TextStyleEnvironmentKey.self] }
        set { self[TextStyleEnvironmentKey.self] = newValue }
    }
}
