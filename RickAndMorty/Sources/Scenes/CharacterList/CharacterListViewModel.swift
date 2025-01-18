//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

@Observable
@MainActor
final class CharacterListViewModel: ViewModelType {
    // MARK: - Dependencies

    // MARK: - View Bindings
    
    public enum Action: Sendable {
        case loading(LoadingAction)
    }

    // MARK: - Coordinator Bindings

    // MARK: - Dependencies

    // MARK: - Variables

    private let apiManager: APIManaging

    // MARK: - Initialization

    init(apiManager: APIManaging) {
        self.apiManager = apiManager
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
            }
        } catch {
            Logger.log("Encountered error in action \(action): \(error)", .error)
        }
    }

    func send(action: LoadingAction) async throws {
        switch action {
        case .task:
            // load content
            throw NSError()
        case .pullToRefresh:
            // refresh content
            throw NSError()
        }
    }
}
