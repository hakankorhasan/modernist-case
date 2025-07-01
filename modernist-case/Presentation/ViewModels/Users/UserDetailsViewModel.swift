//
//  UserDetailsViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import Foundation
import Combine

final class UserDetailsViewModel: ObservableObject {
    
    @Published var isFavorite: Bool = false
    @Published var favoriteUsers: [User] = []

    private var addFavoriteUseCase = AddFavoriteUserUseCase.shared
    private let removeFavoriteUseCase =  RemoveFavoriteUserUseCase.shared
    private let isFavoriteFavoriteUseCase = IsFavoriteUserUseCase.shared

    
    private var cancellables = Set<AnyCancellable>()
    private let user: User
    
    init(user: User) {
        self.user = user
        self.checkIfFavorite()
    }
    
    func toggleFavorite() {
        if isFavorite {
            removeFavoriteUseCase.execute(userId: user.id?.value ?? "")
            isFavorite = false
        } else {
            addFavoriteUseCase.execute(user: user)
            isFavorite = true
        }
    }
    
    private func checkIfFavorite() {
        isFavorite = isFavoriteFavoriteUseCase.execute(userId: user.id?.value ?? "")
    }
}
