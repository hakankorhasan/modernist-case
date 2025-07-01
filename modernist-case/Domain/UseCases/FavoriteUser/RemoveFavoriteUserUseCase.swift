//
//  RemoveFavoriteUserUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
final class RemoveFavoriteUserUseCase {
    
    private let repository: FavoriteUsersRepository

    static let shared = RemoveFavoriteUserUseCase(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute(userId: String) {
        repository.remove(userId: userId)
    }
}

