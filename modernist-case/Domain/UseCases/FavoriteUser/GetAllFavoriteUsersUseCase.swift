//
//  GetAllFavoriteUsersUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import Combine

protocol GetAllFavoriteUsersUseCase {
    func execute() -> AnyPublisher<[User], Never>
}

final class GetAllFavoriteUsersUseCaseImpl: GetAllFavoriteUsersUseCase {
    private let repository: FavoriteUsersRepository

    static let shared = GetAllFavoriteUsersUseCaseImpl(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[User], Never> {
        let users = repository.getAllFavorites()
        return Just(users)
            .eraseToAnyPublisher()
    }
}


