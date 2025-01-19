//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import SwiftUI
import Factory

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.state {
                case .finished:
                    contentView
                case .initial, .loading:
                    EmptyView()
                case .failed:
                    EmptyView()
                }
            }
            .navigationTitle("Characters")
            .background(AssetProvider.Colors.Backgrounds.backgroundsPrimary.swiftUIColor)
        }
        .searchable(text: $viewModel.searchCharacter, prompt: "Search character")
        .task {
            await viewModel.send(action: .loading(.task))
        }
        .refreshable {
            await viewModel.send(action: .loading(.pullToRefresh))
        }
    }
}

private extension CharacterListView {
    var contentView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: ._2) {
                ForEach(viewModel.filteredProducts) { character in
                    CharacterRowView(
                        character: character,
                        isFavorite: false,
                        onCardTap: {
                            await viewModel.send(action: .characterTap)
                        }
                    )
                    .task {
                        await viewModel.send(action: .loadMoreIfNeeded(character))
                    }
                }
            }
            .padding(.top, ._1)
            .padding(.horizontal, ._2)
        }
    }
}

#Preview {
    let _ = Container.shared.characterRepository.register { CharacterRepositoryMock() }
    CharacterListView(viewModel: .init())
}
