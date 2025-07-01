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

    private var fetchUserUseCase = FetchUsersUseCaseImpl.shared
     
     init() {
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
    
    private func filterUsers() {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { user in
                user.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

