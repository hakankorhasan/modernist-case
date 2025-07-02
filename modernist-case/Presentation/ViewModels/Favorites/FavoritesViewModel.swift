//
//  FavoritesViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    
    @Published var isFavorite: Bool = false
    @Published var favoriteUsers: [User] = []

    private var addFavoriteUseCase = AddFavoriteUserUseCaseImpl.shared
    private let removeFavoriteUseCase =  RemoveFavoriteUserUseCaseImpl.shared
    private let isFavoriteFavoriteUseCase = IsFavoriteUserUseCaseImpl.shared
    private let getAllFavoritesUseCase = GetAllFavoriteUsersUseCaseImpl.shared

    
    private var cancellables = Set<AnyCancellable>()
   
    init() {
        self.fetchFavorites()
    }
    
    func fetchFavorites() {
        getAllFavoritesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.favoriteUsers = users
                print(users)
            }
            .store(in: &cancellables)
    }
    
    func removeFromFavorites(user: User) {
        removeFavoriteUseCase.execute(userId: user.id?.value ?? "")
        fetchFavorites()
    }
}
