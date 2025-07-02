//
//  RemoveFavoriteUserUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Combine

protocol RemoveFavoriteUserUseCase {
    func execute(userId: String) -> AnyPublisher<Void, Never>
}

final class RemoveFavoriteUserUseCaseImpl: RemoveFavoriteUserUseCase {
    
    private let repository: FavoriteUsersRepository

    static let shared = RemoveFavoriteUserUseCaseImpl(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute(userId: String) -> AnyPublisher<Void, Never> {
            repository.remove(userId: userId)
            return Just(())
                .eraseToAnyPublisher()
        }
}


