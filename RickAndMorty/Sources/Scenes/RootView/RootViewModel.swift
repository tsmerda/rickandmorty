//
//  RootViewModel.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 19.01.2025.
//

import Foundation
import SwiftUI

public protocol NavigationCoordinator {
    func push(_ path: any Hashable) async
    func popLast() async
}

@MainActor
class RootViewModel: ObservableObject, @preconcurrency Identifiable {

    // MARK: - Types

    public enum Path: Hashable {
        case characterDetail(CharacterDetailViewModel)
    }

    // MARK: - Properties

    public var id = UUID()

    /// The object that handles our navigation stack
    @Published public var paths = NavigationPath()

    /// The ViewModel that represents our first view in the navigation stack
    public lazy var characterListViewModel: CharacterListViewModel = {
        .init(navigator: self)
    }()

}

// MARK: - NavigationCoordinator

extension RootViewModel: NavigationCoordinator {
    public func push(_ path: any Hashable) {
        DispatchQueue.main.async { [weak self] in
            self?.paths.append(path)
        }
    }

    public func popLast() {
        DispatchQueue.main.async { [weak self] in
            self?.paths.removeLast()
        }
    }
}

// MARK: - Preview Mock

extension RootViewModel {
    static var mock: RootViewModel {
        .init()
    }
}



class MockNavigationCoordinator: NavigationCoordinator {

    // MARK: - Types

    typealias OnPush = (_ path: any Hashable) -> Void
    typealias OnPop = () -> Void

    let onPush: OnPush?
    let onPop: OnPop?

    // MARK: - Lifecycle

    init() {
        self.onPush = nil
        self.onPop = nil
    }

    init(onPush: @escaping OnPush, onPop: @escaping OnPop) {
        self.onPush = onPush
        self.onPop = onPop
    }

    // MARK: - NavigationCoordinator

    func push(_ path: any Hashable) {
        onPush?(path)
    }

    func popLast() {
        onPop?()
    }

}
