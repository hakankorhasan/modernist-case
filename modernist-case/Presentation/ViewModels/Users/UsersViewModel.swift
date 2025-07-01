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
    @Published var isLoading = false
    @Published var errorMessage: String?

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
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

