//
//  GlobalNavigationManager.swift
//  modernist-case
//
//  Created by Hakan on 2.07.2025.
//
import SwiftUI
import Combine

@MainActor
class GlobalNavigationManager: ObservableObject {
    static let shared = GlobalNavigationManager()
    
    @Published var fullCoverPath: [ParkyViewName] = []
    
    private init() {}
    
    func push(_ view: ParkyViewName, to path: ReferenceWritableKeyPath<GlobalNavigationManager, [ParkyViewName]> = \.fullCoverPath) {
        DispatchQueue.main.async {
            self[keyPath: path].append(view)
        }
    }
    
    func pop(from path: ReferenceWritableKeyPath<GlobalNavigationManager, [ParkyViewName]> = \.fullCoverPath) {
        DispatchQueue.main.async {
            if !self[keyPath: path].isEmpty {
                self[keyPath: path].removeLast()
            }
        }
    }
}

enum ParkyViewName: Hashable {
    case users
    case favorites
    case userDetails(user: User)
}

