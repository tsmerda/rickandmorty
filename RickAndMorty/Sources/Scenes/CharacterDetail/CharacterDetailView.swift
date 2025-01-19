//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel

    var body: some View {
        ScrollView {
            content
        }
        .background(AssetProvider.Colors.Backgrounds.backgroundsPrimary.swiftUIColor)
    }
}

private extension CharacterDetailView {
    var content: some View {
        CharacterCardView(
            character: viewModel.character,
            isFavorite: viewModel.isFavorite,
            onFavoriteTap: {
                await viewModel.send(action: .onFavoriteTap)
            }
        )
        .padding(.vertical, ._1)
        .padding(.horizontal, ._2)
    }
}

#Preview {
    CharacterDetailView(
        viewModel: .init(
            character: Character.mock,
            navigator: MockNavigationCoordinator()
        )
    )
}
