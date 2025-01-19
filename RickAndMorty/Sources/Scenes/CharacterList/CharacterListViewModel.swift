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
        case characterTap
        case loadMoreIfNeeded(Character)
    }

    // MARK: - Variables

    @Published var characters: [Character] = []
    @Published var state: CharacterLoadingState = .loading
    @Published var searchCharacter: String = ""

    var filteredProducts: [Character] {
        guard !searchCharacter.isEmpty else { return characters }
        return characters.filter { product in
            product.name.lowercased().contains(searchCharacter.lowercased())
        }
    }

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init() {
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
}
