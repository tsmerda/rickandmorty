//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation
import Factory

@Observable
@MainActor
final class CharacterListViewModel: ViewModelType {
    // MARK: - Dependencies

    @ObservationIgnored
    @LazyInjected(\.characterRepository) private var characterRepository

    // MARK: - View Bindings
    
    public enum Action: Sendable {
        case loading(LoadingAction)
        case characterTap
        case loadMoreIfNeeded(Character)
    }

    // MARK: - Coordinator Bindings

    // MARK: - Dependencies

    // MARK: - Variables

    var repositoryState: CharacterLoadingState {
        .loading
    }

    var characters: [Character] {
        characterRepository.characters
    }

    // MARK: - Initialization

    init() {}

    // MARK: - Actions

    @MainActor
    @Sendable
    public func send(action: Action) async {
        Logger.log("\(action)")
        do {
            switch action {
            case let .loading(action):
                try await send(action: action)
            case let .loadMoreIfNeeded(character):
                await characterRepository.loadMoreIfNeeded(for: character)
            case .characterTap:
                throw NSError()
            }
        } catch {
            Logger.log("Encountered error in action \(action): \(error)", .error)
        }
    }

    func send(action: LoadingAction) async throws {
        switch action {
        case .task:
            await characterRepository.load()
        case .pullToRefresh:
            await characterRepository.load()
        }
    }
}
