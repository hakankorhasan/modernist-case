//
//  UsersViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import Combine
import Foundation

import Combine
import Foundation

@MainActor
class UsersViewModel: ObservableObject {
    
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

    private let fetchUserUseCase: FetchUsersUseCase = FetchUsersUseCaseImpl.shared
    private let getAllFavoritesUseCase = GetAllFavoriteUsersUseCaseImpl.shared
    private let addFavoriteUseCase = AddFavoriteUserUseCaseImpl.shared
    private let removeFavoriteUseCase = RemoveFavoriteUserUseCaseImpl.shared

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadFavorites()
        loadUsers()
    }

    func loadUsers() {
        isLoading = true
        errorMessage = nil

        fetchUserUseCase.execute()
            .receive(on: DispatchQueue.main)
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
            .receive(on: DispatchQueue.main)
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
        guard let id = user.id?.value else { return }

        if favorites.contains(id) {
            removeFavoriteUseCase.execute(userId: id)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    self?.favorites.remove(id)
                }
                .store(in: &cancellables)
        } else {
            addFavoriteUseCase.execute(user: user)
                .receive(on: DispatchQueue.main)
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
