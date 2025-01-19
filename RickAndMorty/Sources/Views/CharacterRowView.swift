//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 17.01.2025.
//

import SwiftUI
import Kingfisher

struct CharacterRowView: View {
    let character: Character
    let isFavorite: Bool
    var onCardTap: () async -> Void

    @ScaledMetric private var imageSize: CGFloat = 44

    var body: some View {
        Button {
            Task {
                await onCardTap()
            }
        } label: {
            HStack(alignment: .top, spacing: ._2) {
                avatarView
                infoView
                Spacer()
                Image(.Icons.arrowRight)
                    .foregroundStyle(AssetProvider.Colors.Icons.iconsSecondary.swiftUIColor)
                    .alignmentGuide(
                        .top, computeValue: { dimension in
                            -dimension[.firstTextBaseline]/2
                        }
                    )
            }
        }
        .padding(._1)
        .background(AssetProvider.Colors.Backgrounds.backgroundsTertiary.swiftUIColor)
        .cornerRadius(.medium)
        .shadow(color: .black.opacity(0.04), radius: 16, x: 0, y: 0)
    }
}

private extension CharacterRowView {
    var avatarView: some View {
        KFImage(character.imageUrl)
            .placeholder { AssetProvider.Colors.Backgrounds.backgroundsTertiary.swiftUIColor }
            .resizable()
            .scaledToFill()
            .frame(width: imageSize, height: imageSize)
            .cornerRadius(.xSmall)
    }

    var avatarPlaceholder: some View {
        AssetProvider.Colors.Backgrounds.backgroundsTertiary.swiftUIColor
    }

    var infoView: some View {
        VStack(alignment: .leading, spacing: ._025) {
            HStack(alignment: .top, spacing: ._05) {
                Text(character.name)
                    .textStyle(.headline3)
                    .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsPrimary.swiftUIColor)
                    .multilineTextAlignment(.leading)
                if isFavorite {
                    Image(.Icons.favoritesActive)
                        .foregroundStyle(.accent)
                        .padding(.vertical, ._025)
                }
            }
            Text(character.status)
                .textStyle(.paragraphSmall)
                .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsSecondary.swiftUIColor)
        }
    }
}

#Preview {
    CharacterRowView(
        character: Character.mock,
        isFavorite: true,
        onCardTap: {}
    )
}
