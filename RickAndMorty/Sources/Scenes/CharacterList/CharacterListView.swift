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
        ZStack {
//            switch viewModel.repositoryState {
//            case .finished:
                contentView
//            case .initial, .loading:
//                EmptyView()
//            case .failed:
//                EmptyView()
//            }
        }
        .task {
            await viewModel.send(action: .loading(.task))
        }
    }
}

private extension CharacterListView {
    var contentView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: ._2) {
                ForEach(viewModel.characters) { character in
                    CharacterCardView(
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
        }
        .padding(.horizontal, ._2)
    }
}

#Preview {
    let _ = Container.shared.characterRepository.register { CharacterRepositoryMock() }
    CharacterListView(viewModel: .init())
}
