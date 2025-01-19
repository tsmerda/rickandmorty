//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation
import Factory
import Combine
import ProgressHUD

@MainActor
final class CharacterListViewModel: ViewModelType {
    // MARK: - Dependencies

    @LazyInjected(\.characterRepository) private var characterRepository

    // MARK: - View Bindings

    public enum Action: Sendable {
        case loading(LoadingAction)
        case characterTap(Character)
        case loadMoreIfNeeded(Character)
    }

    // MARK: - Variables

    @Published var characters: [Character] = []
    @Published var state: CharacterLoadingState = .loading
    @Published var searchCharacter: String = ""
    @Published private(set) var favoriteCharacterIDs: Set<Character.ID> = []

    private let navigator: NavigationCoordinator

    var filteredProducts: [Character] {
        guard !searchCharacter.isEmpty else { return characters }
        return characters.filter { product in
            product.name.lowercased().contains(searchCharacter.lowercased())
        }
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(navigator: NavigationCoordinator) {
        self.navigator = navigator
        setupObservations()
    }

    private func setupObservations() {
        characterRepository.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.state = newState
                self?.updateProgressHUD(for: newState)
            }
            .store(in: &cancellables)

        characterRepository.charactersPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$characters)

        characterRepository.favoriteCharactersPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favoriteIDs in
                self?.favoriteCharacterIDs = Set(favoriteIDs)
            }
            .store(in: &cancellables)
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
            case let .loadMoreIfNeeded(character):
                await characterRepository.loadMoreIfNeeded(for: character)
            case let .characterTap(character):
                await onCharacterTap(character)
            }
        } catch {
            Logger.log("Encountered error in action \(action): \(error)", .error)
        }
    }

    func send(action: LoadingAction) async throws {
        switch action {
        case .task:
            if characters == [] {
                await characterRepository.load()
            }
        case .pullToRefresh:
            await characterRepository.load()
        }
    }

    func isFavorite(characterID: Character.ID) -> Bool {
        favoriteCharacterIDs.contains(characterID)
    }

    private func updateProgressHUD(for state: CharacterLoadingState) {
        switch state {
        case .loading:
            ProgressHUD.animate()
        case .failed:
            ProgressHUD.failed()
        case .initial, .finished:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                ProgressHUD.dismiss()
            }
        }
    }

    private func onCharacterTap(_ character: Character) async {
        let detailViewModel = CharacterDetailViewModel(character: character, navigator: navigator)
        await navigator.push(RootViewModel.Path.characterDetail(detailViewModel))
    }
}
