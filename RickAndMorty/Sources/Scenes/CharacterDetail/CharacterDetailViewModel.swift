//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import Foundation
import Factory

@MainActor
final class CharacterDetailViewModel: ViewModelType {
    // MARK: - Dependencies

    @LazyInjected(\.characterRepository) private var characterRepository

    // MARK: - View Bindings

    public enum Action: Sendable {
        case loading(LoadingAction)
        case onFavoriteTap
    }

    // MARK: - Variables

    @Published private(set) var isFavorite: Bool = false

    let character: Character
    private let navigator: NavigationCoordinator
    private var favoriteCharactersTask: Task<Void, Never>?

    // MARK: - Initialization

    init(
        character: Character,
        navigator: NavigationCoordinator
    ) {
        self.character = character
        self.navigator = navigator
        observeFavoriteCharacters()
    }

    // MARK: - Actions

    @MainActor
    @Sendable
    public func send(action: Action) async {
        Logger.log("\(action)")
        do {
            switch action {
            case let .loading(action):
                try await send(action: action)
            case .onFavoriteTap:
                toggleFavoriteStatus()
            }
        } catch {
            Logger.log("Encountered error in action \(action): \(error)", .error)
        }
    }

    func send(action: LoadingAction) async throws {
        switch action {
        case .task:
            break
        case .pullToRefresh:
            break
        }
    }

    private func toggleFavoriteStatus() {
        if isFavorite {
            characterRepository.removeFavorite(characterID: character.id)
        } else {
            characterRepository.addFavorite(characterID: character.id)
        }
    }

    private func observeFavoriteCharacters() {
        favoriteCharactersTask = Task { [weak self] in
            for await favorites in characterRepository.favoriteCharactersPublisher.values {
                guard let self else { return }
                self.isFavorite = favorites.contains(self.character.id)
            }
        }
    }

    deinit {
        favoriteCharactersTask?.cancel()
    }
}

// MARK: - Hashable

extension CharacterDetailViewModel: Hashable {
    nonisolated public static func == (lhs: CharacterDetailViewModel, rhs: CharacterDetailViewModel) -> Bool {
        return lhs.self.character.id == rhs.self.character.id
    }

    nonisolated public func hash(into hasher: inout Hasher) {
        hasher.combine(self.character.id)
    }
}
