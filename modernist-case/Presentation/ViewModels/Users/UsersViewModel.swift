//
//  UsersViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import Combine
import Foundation


@MainActor
class UsersViewModel: ObservableObject {
    
    private let fetchUserUseCase: FetchUsersUseCase
    private let addFavoriteUseCase: AddFavoriteUserUseCase
    private let removeFavoriteUseCase: RemoveFavoriteUserUseCase
    private let getAllFavoritesUseCase: GetAllFavoriteUsersUseCase

    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            filterUsers()
        }
    }
    @Published var favorites: Set<String> = []

    private var cancellables = Set<AnyCancellable>()

    init(
        fetchUserUseCase: FetchUsersUseCase,
        addFavoriteUseCase: AddFavoriteUserUseCase,
        removeFavoriteUseCase: RemoveFavoriteUserUseCase,
        getAllFavoritesUseCase: GetAllFavoriteUsersUseCase
    ) {
        self.fetchUserUseCase = fetchUserUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.getAllFavoritesUseCase = getAllFavoritesUseCase
        
        loadFavorites()
        loadUsers()
    }
    

    func loadUsers() {
        isLoading = true
        errorMessage = nil

        fetchUserUseCase.execute()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
                self?.filterUsers()
            }
            .store(in: &cancellables)
    }

    func loadFavorites() {
        getAllFavoritesUseCase.execute()
            .sink { [weak self] favoriteUsers in
                self?.favorites = Set(favoriteUsers.compactMap { $0.login?.uuid })
            }
            .store(in: &cancellables)
    }

    func isFavorite(_ user: User) -> Bool {
        guard let id = user.login?.uuid else { return false }
        return favorites.contains(id)
    }

    func toggleFavorite(for user: User) {
        guard let id = user.login?.uuid else { return }

        if favorites.contains(id) {
            removeFavoriteUseCase.execute(userId: id)
                .sink { [weak self] in
                    self?.favorites.remove(id)
                }
                .store(in: &cancellables)
        } else {
            addFavoriteUseCase.execute(user: user)
                .sink { [weak self] in
                    self?.favorites.insert(id)
                }
                .store(in: &cancellables)
        }
    }

    private func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter {
                $0.id?.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
}
