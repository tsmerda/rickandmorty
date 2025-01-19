//
//  RootView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel: RootViewModel

    var body: some View {
        NavigationStack(path: $viewModel.paths) {
            CharacterListView(viewModel: viewModel.characterListViewModel)
                .navigationDestination(for: RootViewModel.Path.self) { path in
                    switch path {
                    case let .characterDetail(viewModel):
                        CharacterDetailView(viewModel: viewModel)
                    }
                }
        }
    }
}
