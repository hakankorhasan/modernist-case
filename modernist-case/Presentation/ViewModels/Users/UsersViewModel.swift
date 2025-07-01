//
//  UsersViewModel.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

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

    private var fetchUserUseCase = FetchUsersUseCaseImpl.shared
    private let getAllFavoritesUseCase = GetAllFavoriteUsersUseCase.shared
    private let addFavoriteUseCase = AddFavoriteUserUseCase.shared
    private let removeFavoriteUseCase = RemoveFavoriteUserUseCase.shared
     
     init() {
         loadFavorites()
         Task {
             await loadUsers()
         }
     }

    func loadUsers() async {
        isLoading = true
        defer { isLoading = false }

        do {
            users = try await fetchUserUseCase.execute()
            filterUsers()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loadFavorites() {
        do {
            let favoriteUsers = getAllFavoritesUseCase.execute()
            favorites = Set(favoriteUsers.compactMap { $0.login?.uuid })
        } catch {
            print("Failed to load favorites")
        }
    }
    
    func isFavorite(_ user: User) -> Bool {
        guard let id = user.login?.uuid else { return false }
        return favorites.contains(id)
    }
    
    func toggleFavorite(for user: User) {
        guard let id = user.id?.value else { return }

        if favorites.contains(id) {
            do {
                removeFavoriteUseCase.execute(userId: user.id?.value ?? "")
                favorites.remove(id)
            } catch {
                print("Failed to remove favorite")
            }
        } else {
            do {
                addFavoriteUseCase.execute(user: user)
                favorites.insert(id)
            } catch {
                print("Failed to add favorite")
            }
        }
    }
    
    private func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { user in
                user.id?.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
}

