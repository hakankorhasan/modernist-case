//
//  AddFavoriteUserUseCase.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//
import Combine

protocol AddFavoriteUserUseCase {
    func execute(user: User) -> AnyPublisher<Void, Never>
}

final class AddFavoriteUserUseCaseImpl: AddFavoriteUserUseCase {
    private let repository: FavoriteUsersRepository

    static let shared = AddFavoriteUserUseCaseImpl(repository: FavoriteUsersRepositoryImpl.shared)
    
    init(repository: FavoriteUsersRepository) {
        self.repository = repository
    }

    func execute(user: User) -> AnyPublisher<Void, Never> {
        repository.add(user: user)
        return Just(())
            .eraseToAnyPublisher()
    }
}


