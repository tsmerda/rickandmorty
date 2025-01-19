//
//  CharacterCardView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import SwiftUI
import Kingfisher

struct CharacterCardView: View {
    let character: Character
    let isFavorite: Bool
    var onFavoriteTap: () async -> Void

    @ScaledMetric private var imageSize: CGFloat = 140

    private var favoriteIcon: ImageAsset.Image { // TODO: - fix make it ImageAsset
        isFavorite ? .Icons.favoritesSelected : .Icons.favoritesEnabled // TODO: - fix icon size
    }

    private var favoriteColor: Color {
        isFavorite ? .accent : AssetProvider.Colors.Icons.iconsSecondary.swiftUIColor
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .top, spacing: ._2) {
                avatarView
                VStack(alignment: .leading, spacing: ._05 + ._025) {
                    HStack(alignment: .top) {
                        Text("Name")
                            .textStyle(.paragraphMedium)
                            .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsSecondary.swiftUIColor)
                        Spacer()
                        Button {
                            Task {
                                await onFavoriteTap()
                            }
                        } label: {
                            Image(uiImage: favoriteIcon) // TODO: - fix
                                .foregroundStyle(favoriteColor)
                        }
                    }
                    Text(character.name)
                        .textStyle(.headline2)
                        .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsPrimary.swiftUIColor)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(._2)

            Divider()
                .background(AssetProvider.Colors.Foregrounds.foregroundsSeparator.swiftUIColor)

            Grid(
                alignment: .leading,
                horizontalSpacing: Spacing._5.value,
                verticalSpacing: Spacing._3.value
            ) {
                ForEach(CharacterInfo.all(for: character), id: \.self) { info in
                    GridRow {
                        Text(info.label)
                            .textStyle(.paragraphSmall)
                            .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsSecondary.swiftUIColor)
                        Text(info.value)
                            .textStyle(.headline3)
                            .foregroundStyle(AssetProvider.Colors.Foregrounds.foregroundsPrimary.swiftUIColor)
                    }
                }
            }
            .padding(._3)
        }
        .background(AssetProvider.Colors.Backgrounds.backgroundsTertiary.swiftUIColor)
        .cornerRadius(.medium)
        .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 0)
    }
}

private extension CharacterCardView {
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
}

#Preview {
    CharacterCardView(
        character: Character.mock,
        isFavorite: true,
        onFavoriteTap: {} // TODO: - large name vertically align
    )
}
