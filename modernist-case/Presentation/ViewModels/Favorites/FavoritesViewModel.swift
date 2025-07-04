//
//  FavoritesViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    
    @Published var favoriteUsers: [User] = []
    @Published var isFavorite: Bool = false

    private let addFavoriteUseCase: AddFavoriteUserUseCase
    private let removeFavoriteUseCase: RemoveFavoriteUserUseCase
    private let isFavoriteUseCase: IsFavoriteUserUseCase
    private let getAllFavoritesUseCase: GetAllFavoriteUsersUseCase
    
    private var cancellables = Set<AnyCancellable>()
   
    init(
        addFavoriteUseCase: AddFavoriteUserUseCase,
        removeFavoriteUseCase: RemoveFavoriteUserUseCase,
        isFavoriteUseCase: IsFavoriteUserUseCase,
        getAllFavoritesUseCase: GetAllFavoriteUsersUseCase
    ) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
        self.getAllFavoritesUseCase = getAllFavoritesUseCase
        
        fetchFavorites()
    }
    
    func fetchFavorites() {
        getAllFavoritesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error fetching favorites: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] users in
                self?.favoriteUsers = users
            }
            .store(in: &cancellables)
    }
    
    func removeFromFavorites(user: User) {
        guard let userId = user.id?.value else { return }
        removeFavoriteUseCase.execute(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error removing favorite: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] in
                self?.fetchFavorites()
            }
            .store(in: &cancellables)
    }
}
