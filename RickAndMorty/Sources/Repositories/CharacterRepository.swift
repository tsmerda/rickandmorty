//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Factory
import Foundation
import Combine

typealias CharacterLoadingState = CharacterRepository.State

protocol CharacterRepositoryType: ObservableObject {
    var statePublisher: AnyPublisher<CharacterLoadingState, Never> { get }
    var charactersPublisher: AnyPublisher<[Character], Never> { get }
    var favoriteCharactersPublisher: AnyPublisher<[Character.ID], Never> { get }

    func load() async
    func loadMoreIfNeeded(for character: Character) async
    func addFavorite(characterID: Character.ID)
    func removeFavorite(characterID: Character.ID)
}

final class CharacterRepository: CharacterRepositoryType {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }

    @LazyInjected(\.apiManager) private var apiManager

    @Published private var state: CharacterLoadingState = .initial
    @Published private var characters: [Character] = []
    @Published private var favoriteCharacters: [Character.ID] = []

    private let favoritesKey = "FavoriteCharacters" // TODO: - add to constants

    var statePublisher: AnyPublisher<State, Never> {
        $state.eraseToAnyPublisher()
    }

    var charactersPublisher: AnyPublisher<[Character], Never> {
        $characters.eraseToAnyPublisher()
    }

    var favoriteCharactersPublisher: AnyPublisher<[Character.ID], Never> {
        $favoriteCharacters.eraseToAnyPublisher()
    }

    private var currentResponseInfo: PaginationInfo?

    init() {
        loadFavoriteCharacters()
    }
}

extension CharacterRepository {
    func load() async {
        state = .loading

        await fetch()
    }

    func loadMoreIfNeeded(for character: Character) async {
        guard character == characters.last else {
            return
        }
        guard let nextPageNumber = currentResponseInfo?.nextPageNumber else {
            return
        }

        state = .finished(loadingMore: true)
        await fetch(page: nextPageNumber)
    }

    func addFavorite(characterID: Character.ID) {
        guard !favoriteCharacters.contains(characterID) else { return }
        favoriteCharacters.append(characterID)
        saveFavoriteCharacters()
    }

    func removeFavorite(characterID: Character.ID) {
        favoriteCharacters.removeAll { $0 == characterID }
        saveFavoriteCharacters()
    }

    func saveFavoriteCharacters() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(favoriteCharacters) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }

    func loadFavoriteCharacters() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let favorites = try? decoder.decode([Character.ID].self, from: data) {
            favoriteCharacters = favorites
        }
    }
}

private extension CharacterRepository {
    func fetch(page: Int? = nil) async {
        let endpoint = CharactersRouter.getCharacters(page: page)

        do {
            let response: PaginatedResponse<Character> = try await apiManager.request(endpoint)
            currentResponseInfo = response.info
            characters += response.results
            state = .finished(loadingMore: false)
        } catch {
            Logger.log("\(error)", .error)
            state = .failed
        }
    }
}


extension Container {
    var characterRepository: Factory<any CharacterRepositoryType> {
        self { CharacterRepository() }
            .cached
    }
}

public final class CharacterRepositoryMock: CharacterRepositoryType {
    @Published private var state: CharacterLoadingState = .finished(loadingMore: false)
    @Published private var characters: [Character] = Character.mockArray
    @Published private var favoriteCharacters: [Character.ID] = []

    var statePublisher: AnyPublisher<CharacterLoadingState, Never> {
        $state.eraseToAnyPublisher()
    }

    var charactersPublisher: AnyPublisher<[Character], Never> {
        $characters.eraseToAnyPublisher()
    }

    var favoriteCharactersPublisher: AnyPublisher<[Character.ID], Never> {
        $favoriteCharacters.eraseToAnyPublisher()
    }

    func load() async {}

    func loadMoreIfNeeded(for character: Character) async {}

    func addFavorite(characterID: Character.ID) {
        favoriteCharacters.append(characterID)
    }

    func removeFavorite(characterID: Character.ID) {
        favoriteCharacters.removeAll { $0 == characterID }
    }
}
