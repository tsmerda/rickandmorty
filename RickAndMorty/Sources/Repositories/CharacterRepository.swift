//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Factory
import Foundation

typealias CharacterLoadingState = CharacterRepository.State

protocol CharacterRepositoryType: ObservableObject {
    var state: CharacterLoadingState { get }
    var characters: [Character] { get }

    func load() async
    func loadMoreIfNeeded(for character: Character) async
}

final class CharacterRepository: CharacterRepositoryType {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }

    @LazyInjected(\.apiManager) private var apiManager

    @Published var state: State = .initial
    @Published var characters: [Character] = .init()

    private var currentResponseInfo: PaginationInfo?

    init() {}
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
    @Published var state: CharacterLoadingState = .initial
    @Published var characters: [Character] = Character.mockArray

    func load() async {}

    func loadMoreIfNeeded(for character: Character) async {}
}
