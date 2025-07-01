//
//  AddFavoriteUserUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
final class AddFavoriteUserUseCase {
    private let repository: FavoriteUsersRepository

    static let shared = AddFavoriteUserUseCase(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute(user: User) {
        repository.add(user: user)
    }
}

