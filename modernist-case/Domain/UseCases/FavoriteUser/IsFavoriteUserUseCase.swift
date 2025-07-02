//
//  IsFavoriteUserUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Combine

protocol IsFavoriteUserUseCase {
    func execute(userId: String) -> AnyPublisher<Bool, Never>
}

final class IsFavoriteUserUseCaseImpl: IsFavoriteUserUseCase {
    private let repository: FavoriteUsersRepository

    static let shared = IsFavoriteUserUseCaseImpl(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute(userId: String) -> AnyPublisher<Bool, Never> {
        let isFav = repository.isFavorite(userId: userId)
        return Just(isFav)
            .eraseToAnyPublisher()
    }
}



