//
//  GetAllFavoriteUsersUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

final class GetAllFavoriteUsersUseCase {
    private let repository: FavoriteUsersRepository

    static let shared = GetAllFavoriteUsersUseCase(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute() -> [User] {
        repository.getAllFavorites()
    }
}
