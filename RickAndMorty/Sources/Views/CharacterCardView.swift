//
//  CharacterCardView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 17.01.2025.
//

import SwiftUI

struct CharacterCardView: View {
    let avatar: ImageResource
    let name: String
    let status: String
    let isFavorite: Bool
    
    @ScaledMetric private var imageSize: CGFloat = 44
    
    var body: some View {
        HStack(spacing: ._2) {
            avatarView
            infoView
            Spacer()
            Image(.Icons.arrowRight)
                .foregroundStyle(AssetProvider.Colors.Icons.iconsSecondary.swiftUIColor)
        }
        .padding(._1)
        .background(AssetProvider.Colors.Backgrounds.backgroundsTertiary.swiftUIColor)
        .shadow(color: .black.opacity(0.04), radius: 16, x: 0, y: 0)
    }
}

private extension CharacterCardView {
    var avatarView: some View {
        Image(avatar)
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .cornerRadius(.xSmall)
    }
    var infoView: some View {
        VStack(alignment: .leading, spacing: ._025) {
            HStack(spacing: ._05) {
                Text(name)
                    .textStyle(.headline3)
                    .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsPrimary.swiftUIColor)
                if isFavorite {
                    Image(.Icons.favoritesActive)
                        .foregroundStyle(.accent)
                }
            }
            Text(status)
                .textStyle(.paragraphSmall)
                .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsSecondary.swiftUIColor)
        }
    }
}

#Preview {
    CharacterCardView(
        avatar: .Images._12Alexander,
        name: "Eric Stoltz Mask Morty", // TODO: - large name vertically align
        status: "Alive",
        isFavorite: true // TODO: - large name vertically align
    )
}
