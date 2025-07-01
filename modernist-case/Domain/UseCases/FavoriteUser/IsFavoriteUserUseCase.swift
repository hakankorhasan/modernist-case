//
//  IsFavoriteUserUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
final class IsFavoriteUserUseCase {
    private let repository: FavoriteUsersRepository

    static let shared = IsFavoriteUserUseCase(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute(userId: Int) -> Bool {
        repository.isFavorite(userId: userId)
    }
}

