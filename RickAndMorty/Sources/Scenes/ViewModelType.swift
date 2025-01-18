//
//  ViewModelType.swift
//  RickAndMorty
//
//  Created by Tomáš Šmerda on 18.01.2025.
//

import Foundation

public protocol ViewModelType: ObservableObject {
    associatedtype Action
    
    @MainActor
    func send(action: Action) async
}
