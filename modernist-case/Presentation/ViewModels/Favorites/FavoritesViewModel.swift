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

    private var addFavoriteUseCase = AddFavoriteUserUseCase.shared
    private let removeFavoriteUseCase =  RemoveFavoriteUserUseCase.shared
    private let isFavoriteFavoriteUseCase = IsFavoriteUserUseCase.shared
    private let getAllFavoritesUseCase = GetAllFavoriteUsersUseCase.shared

    
    private var cancellables = Set<AnyCancellable>()
   
    init() {
        self.fetchFavorites()
    }
    
    func fetchFavorites() {
        do {
            favoriteUsers = getAllFavoritesUseCase.execute()
            print(favoriteUsers)
        } catch {
            print("error")
        }
    }
}
