//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel: CharacterListViewModel

    var body: some View {
        ScrollView {
            Text("Hello, World!")
        }
        .task {
            await viewModel.send(action: .loading(.task))
        }
    }
}

private extension CharacterListView {

}

#Preview {
    CharacterListView(viewModel: .init(apiManager: APIManager()))
}
